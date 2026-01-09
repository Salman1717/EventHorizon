//
//  PhysicalLimits.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 09/01/26.
//

import Foundation

// Safe Numerical Limits for the simulation
enum PhysicalLimits{
    
    /// Max allowed velocity as fraction of c
    /// Done to avoid  gamma -> infinity
    static let maxVelocityFractionOfC: Double = 0.999_999
}
