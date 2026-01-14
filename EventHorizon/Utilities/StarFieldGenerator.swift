//
//  StarFieldGenerator.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 12/01/26.
//

import Foundation
import CoreGraphics

enum StarFieldGenerator{
    
    static func generate(count: Int) -> [Star]{
        (0..<count).map { _ in
            
            let x = Double.random(in: -1...1)
            let y = Double.random(in: -1...1)
            
            let magnitude = max (0.001, sqrt(x*x + y*y))
            
            return Star(
                position: CGPoint(
                    x: x,
                    y: y
                ),
                direction: CGVector(
                    dx: x / magnitude,
                    dy: y / magnitude
                ),
                
                depth: Double.random(in: 0.1...1.0)
            )
        }
    }
}
