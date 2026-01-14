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
                .foregroundStyle(.blue)
            
            Text(TimeFormatter.format(time))
                .font(.title2.monospacedDigit())
                .foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom))
        }
        .padding()
        .frame(width: 150)
        .background(clockBg())
        
    }
    
    private func clockBg() -> some View{
        RoundedRectangle(cornerRadius: 16)
            .foregroundStyle(.blue.opacity(0.2))
            .overlay{
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.blue)
            }
    }
}

#Preview {
    ClockView(title: "Salman's Clock", time: 121102)
}
