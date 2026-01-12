//
//  SpaceSceneView.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 09/01/26.
//

import SwiftUI

struct SpaceSceneView: View {
    
    @StateObject private var viewModel = SimulationViewModel()
    private let stars = StarFieldGenerator.generate(count: 800)
    
    var body: some View {
        TimelineView(.animation) { timeline in
            ZStack {
                Color.black.ignoresSafeArea()
                
                StarfieldView(
                    stars: stars,
                    velocityFraction: viewModel.velocityFractionOfC
                )
                
                
                
                VStack(spacing: 24) {
                    ClockView(title: "Earth Time", time: viewModel.earthTime)
                    ClockView(title: "Traveler Time", time: viewModel.travelerTime)
                    
                    SpaceAxisView(
                        contractionFactor: viewModel.lengthContraction
                    )
                    
                    velocityControl
                    controlPannel
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
    
    private var controlPannel: some View{
        HStack(spacing: 16){
            
            Button("Pause"){
                viewModel.paused()
            }
            .disabled(viewModel.mode == .paused)
            
            Button("Resume"){
                viewModel.resume()
            }
            .disabled(viewModel.mode == .running)
            
            Button("Step +1s"){
                viewModel.step()
            }
            
            Button("Reset"){
                viewModel.reset()
            }
            
        }
    }
}

#Preview {
    SpaceSceneView()
}
