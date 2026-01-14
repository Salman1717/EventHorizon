//
//  SimulationViewModel.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 09/01/26.
//

import Foundation
import Combine

enum SimulationMode{
    case running
    case paused
}


//MARK: Simulation ViewModel
// Owns all time progression and enforces physical constraints
@MainActor
final class SimulationViewModel: ObservableObject {
    
    //MARK: - Published States
    
    /// Earth time in seconds (coordinate time)
    @Published private(set) var earthTime: TimeInterval = 0
    /// Traveler Time in seconds
    @Published private(set) var travelerTime: TimeInterval = 0
    /// Velocity as a fraction of speed of light
    @Published var velocityFractionOfC: Double = 0.0 {
        didSet{
            let clamped = clampVelocity(velocityFractionOfC)
            if velocityFractionOfC != clamped {
                velocityFractionOfC = clamped
            }
        }
    }
    
    @Published private(set) var mode:SimulationMode = .running
    
    //MARK: - Internal State
    
    /// Last updated time
    private var lastUpdate: Date?
    
    var velocity: Double{
        velocityFractionOfC * PhysicalConstants.speedOfLight
    }
    
    // MARK: - Logic
    
    /// Advances simulation time only when running
    func update(currentDate: Date) {
        
        guard mode == .running else{
            lastUpdate = currentDate
            return
        }
        
        let delta = currentDate.timeIntervalSince(lastUpdate ?? currentDate)
        lastUpdate = currentDate
        
        guard delta > 0 else { return }
        
        advance(by: delta)
    }
    
    /// Deterministic Advancement
    func advance(by delta: TimeInterval){
        /// Advance earth time
        earthTime += delta
        
        /// Conver fraction -> Real veolicty (m/s)
        let velocity = velocityFractionOfC * PhysicalConstants.speedOfLight
        
        /// Advance traveler time using relativistic dilation
        let dilatedDelta = RelativityEngine.dilatedTime(
            earthDelta: delta,
            velocity: velocity
        )
        
        travelerTime += dilatedDelta
    }
    
    /// Lorentz length contraction factor (0 < factor ≤ 1)
    var lengthContraction: Double{
        let velocity = velocityFractionOfC * PhysicalConstants.speedOfLight
        return RelativityEngine.lengthContractionFactor(for: velocity)
    }
    //MARK: - Controls
    
    func paused(){
        mode = .paused
        
    }
    
    /// Prevents time jump when resuming
    func resume(){
        lastUpdate = Date()
        mode = .running
    }
    
    /// Fixed Step: 1 sec of earth time
    func step(){
        advance(by: 1.0)
    }
    
    /// Reset the simulation
    func reset(){
        earthTime = 0
        travelerTime = 0
        mode = .paused
        lastUpdate = nil
    }
    
    // MARK: - Helpers
    
    private func clampVelocity(_ value: Double) -> Double {
        min(max(value, 0), PhysicalLimits.maxVelocityFractionOfC)
    }
}

