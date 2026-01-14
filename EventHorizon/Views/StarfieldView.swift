//
//  StarfieldView.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 12/01/26.
//

import SwiftUI

struct StarfieldView: View {
    
    let stars: [Star]
    let velocityFractionOfC: Double
    let earthTime: TimeInterval
    
    var body: some View {
        Canvas { context, size in
            
            let center = CGPoint(
                x: size.width / 2,
                y: size.height / 2
            )
            
            let maxDimension = max(size.width, size.height)
            
            for star in stars {
                
                // Base position (static distribution)
                let baseX = center.x + star.position.x * size.width * 0.5
                let baseY = center.y + star.position.y * size.height * 0.5
                
                // Wrapped travel (bounded motion)
                let speed = velocityFractionOfC * 300 * (1 / star.depth)
                let travel = speed * earthTime
                let wrappedTravel =
                travel.truncatingRemainder(dividingBy: maxDimension)
                
                let compressedDirection = RelativisticCompression.compress(
                    direction: star.direction,
                    velocityFraction: velocityFractionOfC
                )
                
                // Directional offset
                let offsetX = compressedDirection.dx * wrappedTravel
                let offsetY = compressedDirection.dy * wrappedTravel
                
                let x = baseX + offsetX
                let y = baseY + offsetY
                
                let opacity = max(0.3, 1 - star.depth)
                let radius = max(0.6, 2.5 * (1 - star.depth))
                
                let blurLength = velocityFractionOfC * 40 * (1 - star.depth)
                
                if blurLength > 0.5 {
                    let blurPath = Path { path in
                        path.move(to: CGPoint(x: x, y: y))
                        path.addLine(
                            to: CGPoint(
                                x: x - star.direction.dx * blurLength,
                                y: y - star.direction.dy * blurLength
                            )
                        )
                    }
                    
                    context.stroke(
                        blurPath,
                        with: .color(
                            DopplerColor.color(
                                velocityFraction: velocityFractionOfC,
                                depth: star.depth
                            )
                        ),
                        lineWidth: radius * 0.8)
                }
                
                let rect = CGRect(
                    x: x,
                    y: y,
                    width: radius,
                    height: radius
                )
                
                context.fill(
                    Path(ellipseIn: rect),
                    with: .color(
                        DopplerColor
                            .color(velocityFraction: velocityFractionOfC, depth: star.depth)
                            .opacity(opacity)
                    )
                )
            }
        }
        .ignoresSafeArea()
    }
}
