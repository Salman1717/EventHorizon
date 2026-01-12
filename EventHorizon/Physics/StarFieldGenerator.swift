//
//  StarFieldGenerator.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 12/01/26.
//

import Foundation

enum StarFieldGenerator{
    
    static func generate(count: Int) -> [Star]{
        (0..<count).map { _ in
            Star(
                position: CGPoint(
                    x: Double.random(in: -1...1),
                    y: Double.random(in: -1...1)
                ),
                depth: Double.random(in: 0.1...1.0)
            )
        }
    }
}
