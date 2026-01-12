//
//  SpaceAxisView.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 11/01/26.
//

import SwiftUI

struct SpaceAxisView: View {
    
    let contractionFactor: Double
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(
                LinearGradient(
                    colors: [.blue, .purple],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .scaleEffect(x: contractionFactor, y: 1.0, anchor: .center)
            .animation(.linear(duration: 0.1), value: contractionFactor)
                
    }
}

#Preview {
    SpaceAxisView(contractionFactor: 0.8)
}
