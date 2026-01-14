//
//  CustomButtonStyle.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 14/01/26.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    let image: String
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: image)
            .frame(width: 20, height: 20)
            .foregroundStyle(LinearGradient(colors: [.red, .purple], startPoint: .top, endPoint: .bottom))
            .padding()
            .background{
                
                Circle()
                    .foregroundStyle(.blue.opacity(0.2))
                    .overlay{
                        Circle()
                            .stroke(lineWidth: 1)
                            .foregroundStyle(.blue)
                    }
                
            }
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
        
    }
}
