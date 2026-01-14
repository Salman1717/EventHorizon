//
//  StarfieldViewModel.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 14/01/26.
//

import Foundation
import Combine

@MainActor
final class StarfieldViewModel: ObservableObject {
    
    // MARK: - Published State
    @Published private(set) var stars: [Star] = []
    
    // MARK: - Init
    init(starCount: Int) {
        self.stars = StarFieldGenerator.generate(count: starCount)
    }
    
    // MARK: - Wrapped Motion (Stable & Bounded)
    
    /// Returns the wrapped travel distance for a given star
    /// Keeps motion bounded regardless of simulation time
    func travelDistance(
        for star: Star,
        velocityFractionOfC: Double,
        earthTime: TimeInterval,
        maxDimension: CGFloat
    ) -> CGFloat {
        
        let speed = velocityFractionOfC * 300 * (1 / star.depth)
        let travel = speed * earthTime
        
        return travel.truncatingRemainder(dividingBy: maxDimension)
    }
}
