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
    
    var body: some View {
        Canvas{ context, size in
            
            let center = CGPoint(x: (size.width / 2), y: (size.height / 2))
            
            for star in stars{
                
                /// Base position
                let baseX = center.x + star.position.x * size.width * 0.5
                let baseY = center.y + star.position.y * size.height * 0.5
                
                ///realistic outward movement
                let motion = velocityFraction * 600 * (1 / star.depth)
                
                let dx = (baseX - center.x) / size.width
                let dy = (baseY - center.y) / size.height
                
                
                let x = baseX + dx * motion
                let y = baseY + dy * motion
                
                let opacity = max(0.3, 1 - star.depth)
                let radius = max(0.5, 2.5 * (1 - star.depth))
                
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
