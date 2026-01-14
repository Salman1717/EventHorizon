//
//  RelativisticCompression.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 14/01/26.
//

import Foundation

enum RelativisticCompression{
    
    // Compress a direction vector to wards the forward axis
    
    static func compress(direction: CGVector, velocityFraction: Double) -> CGVector{
        
        /// How strong the compression is
        let compression = max(0.3, 1 - velocityFraction * 0.7)
        
        /// Compress Perpendicular component
        let dx = direction.dx  * compression
        let dy = direction.dy * compression
        
        /// Renormalize
        let magnitude = max(0.0001, sqrt(dx*dx + dy*dy))
        
        return CGVector(
            dx: dx / magnitude,
            dy: dy / magnitude
        )
    }
    
}
