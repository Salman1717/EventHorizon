//
//  StarfieldView.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 12/01/26.
//

import SwiftUI

struct StarfieldView: View {
    
    let stars:[Star]
    let velocityFraction: Double
    let earthTime: TimeInterval
    
    var body: some View {
        Canvas{ context, size in
            
            let center = CGPoint(x: (size.width / 2), y: (size.height / 2))
            
            for star in stars{
                
                /// Base position
                let baseX = center.x + star.position.x * size.width * 0.5
                let baseY = center.y + star.position.y * size.height * 0.5
                
                ///speed scales with velocity and depth
                let speed = velocityFraction * 300 * (1 / star.depth)
                
                
                let travel = speed * earthTime
                
                let wrappedTravel = travel.truncatingRemainder(
                    dividingBy: max(size.width, size.height)
                )
                
                /// Continuious movement using time
                let offsetX = star.direction.dx * wrappedTravel
                let offsetY = star.direction.dy * wrappedTravel
                
                let x = baseX + offsetX
                let y = baseY + offsetY
                
                let opacity = max(0.3, 1 - star.depth)
                let radius = max(0.6, 2.8 * (1 - star.depth))
                
                let rect = CGRect(
                    x: x,
                    y: y,
                    width: radius,
                    height: radius
                )
                
                context.fill(
                    Path(ellipseIn: rect),
                    with: .color(.white.opacity(opacity))
                )
            }
        }.ignoresSafeArea()
    }
}

//#Preview {
//    StarfieldView()
//}
