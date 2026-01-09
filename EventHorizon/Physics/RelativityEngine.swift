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
    
}
