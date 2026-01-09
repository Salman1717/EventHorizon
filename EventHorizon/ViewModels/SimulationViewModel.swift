//
//  SimulationViewModel.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 09/01/26.
//

import Foundation
import Combine

//MARK: Simulation ViewModel

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
    
    //MARK: - Internal State
    
    /// Last updated time
    private var lastUpdate: Date?
    
    // MARK: - Logic
    
    /// Advances the simulation using real elasped time
    func update(currentDate: Date) {
        let delta = currentDate.timeIntervalSince(lastUpdate ?? currentDate)
        lastUpdate = currentDate
        
        guard delta > 0 else { return }
        
        /// Advance earth time
        earthTime += delta
        
        /// Conver fraction -> Real veolicty (m/s)
        let velocity = velocityFractionOfC * PhysicalConstants.speedOfLight
        
        /// Advance traveler time using relativistic dilation
        let dilatedDelta = RelativityEngine.dilatedTime(earthDelta: delta, velocity: velocity)
        
        travelerTime += dilatedDelta
    }
    
    /// Reset the simulation
    func reset(){
        earthTime = 0
        travelerTime = 0
        lastUpdate = nil
    }
    
    func tick(){
        let now = Date()
        update(currentDate: now)
    }
    
    // MARK: - Helpers
    
    private func clampVelocity(_ value: Double) -> Double {
        min(max(value, 0), PhysicalLimits.maxVelocityFractionOfC)
    }
}
