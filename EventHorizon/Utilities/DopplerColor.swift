//
//  DopplerColor.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 14/01/26.
//

import Foundation
import SwiftUI

enum DopplerColor{
    /// Returns a color shifted by velocity (physically motivated)
    static func color(velocityFraction: Double, depth: Double) -> Color{
        
        /// Doppler intensity factor
        let shift = velocityFraction * (1 - depth)
        
        /// Clamp to prevent extremes
        let clamped = min(max(shift,0), 0.2)
        
        // Base white → blue shift
        let red = 1.0 - clamped
        let green = 1.0 - clamped * 0.5
        let blue = 1.0
        
        return Color(
            red: red,
            green: green,
            blue: blue
        )
    }
}
