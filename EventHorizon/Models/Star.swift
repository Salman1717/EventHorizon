//
//  Star.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 12/01/26.
//

import Foundation

struct Star: Identifiable{
    let id = UUID()
    let position: CGPoint  ///normalized (-1..1)
    let direction: CGVector
    let depth: Double // (0) Near -> (1)Far
}
