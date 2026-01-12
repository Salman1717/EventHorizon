//
//  RelativityEngine.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 07/01/26.
//

import Foundation

// MARK: RelativityEngine
// Implements Einstein's  special relativity equations

struct RelativityEngine {
    
    //MARK: - Lorentz Factor (gamma)
    /// Lorentz Factor: γ = 1 / √(1 - v²/c²)
    /// where v = relative velocity and c = speed of light
    static func gamma(for velocity: Double) -> Double {
        let c = PhysicalConstants.speedOfLight
        let ratio = velocity / c
        let gamma = 1.0 / sqrt(1.0 -  ratio * ratio)
        return gamma
    }
    
    // MARK: - Traveler Time Dilation
    /// Traveler Time Dilation (Proper Time)
    /// t_proper = t_observer / gamma
    /// OR
    /// t_proper = t_observer * sqrt(1 - (v^2 / c^2))
    static func dilatedTime( earthDelta : TimeInterval, velocity: Double ) -> TimeInterval {
        let gamma = gamma(for: velocity)
        return earthDelta / gamma
    }
    
    // MARK: - Lorentz Length Contraction
    ///Lorentz length contraction is a phenomenon from Einstein's special relativity where an object moving at a significant fraction of the speed of light 
    ///appears shorter to a stationary observer, but only in the direction of its motion; the effect becomes noticeable only at relativistic speeds
    static func lengthContractionFactor(for velocity: Double) -> Double {
        let gamma = gamma(for: velocity)
        return 1.0 / gamma
    }
}
