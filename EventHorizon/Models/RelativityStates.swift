//
//  RelativityStates.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 07/01/26.
//

import Foundation

// Represents the physical state of the  traveler

struct RelativityStates {
    
    /// Velocity of the traveler(m/s)
    let velocity: Double
    
    /// Proper Time Experienced by the traveller (seconds)
    let travelerTime: TimeInterval
    
    ///  Coordinate Time Measured on Earth (seconds)
    let earthTime: TimeInterval
}
