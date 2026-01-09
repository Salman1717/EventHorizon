//
//  ClockView.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 09/01/26.
//

import SwiftUI

struct ClockView: View {
    
    let title: String
    let time: TimeInterval
    
    var body: some View {
        VStack(spacing: 8){
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text(TimeFormatter.format(time))
                .font(.title.monospacedDigit())
                .foregroundStyle(.white)
        }
        .padding()
        .frame(width: 200)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    ClockView(title: "Salman's Clock", time: 121102)
}
