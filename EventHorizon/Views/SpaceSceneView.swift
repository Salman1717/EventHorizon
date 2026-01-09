//
//  SpaceSceneView.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 09/01/26.
//

import SwiftUI

struct SpaceSceneView: View {
    
    @StateObject private var viewModel = SimulationViewModel()
    
    var body: some View {
        TimelineView(.animation) { timeline in
            ZStack{
                Color.black.ignoresSafeArea()
                
                VStack(spacing:24){
                    
                    ClockView(
                        title: "Earth Time",
                        time: viewModel.earthTime
                    )
                    
                    ClockView(
                        title: "Traveler Time",
                        time: viewModel.travelerTime
                    )
                    
                    velocityControl
                    
                }
            }
            .task(id: timeline.date){
                viewModel.update(currentDate: timeline.date)
            }
        }
    }
    
    private var velocityControl: some View{
        VStack(spacing: 8){
            Text("Velocity: \(String(format: "%.3f", viewModel.velocityFractionOfC)) c")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Slider(
                value: $viewModel.velocityFractionOfC,
                in: 0...PhysicalLimits.maxVelocityFractionOfC
            )
        }
        .padding(.horizontal)
    }
}

#Preview {
    SpaceSceneView()
}
