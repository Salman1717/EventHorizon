//
//  SpaceSceneView.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 09/01/26.
//

import SwiftUI

struct SpaceSceneView: View {
    
    @StateObject private var simVM = SimulationViewModel()
    @StateObject private var starfieldVM = StarfieldViewModel(starCount: 800)
    
    var body: some View {
        TimelineView(.animation) { timeline in
            ZStack {
                Color.black.ignoresSafeArea()
                
                StarfieldView(stars: starfieldVM.stars, velocityFractionOfC: simVM.velocityFractionOfC, earthTime: simVM.earthTime)
                
                
                
                
                VStack(spacing: 24) {
                    ClockView(title: "Earth Time", time: simVM.earthTime)
                    ClockView(title: "Traveler Time", time: simVM.travelerTime)
                    
                    //                    SpaceAxisView(
                    //                        contractionFactor: viewModel.lengthContraction
                    //                    )
                    
                    velocityControl
                    controlPannel
                }
            }
            .task(id: timeline.date){
                simVM.update(currentDate: timeline.date)
            }
        }
    }
    
    private var velocityControl: some View{
        VStack(spacing: 8){
            Text("Velocity: \(String(format: "%.3f", simVM.velocityFractionOfC)) c")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Slider(
                value: $simVM.velocityFractionOfC,
                in: 0...PhysicalLimits.maxVelocityFractionOfC
            )
        }
        .padding(.horizontal)
    }
    
    private var controlPannel: some View{
        HStack(spacing: 16){
            
            Button("Pause"){
                simVM.paused()
            }
            .disabled(simVM.mode == .paused)
            
            Button("Resume"){ 
                simVM.resume()
            }
            .disabled(simVM.mode == .running)
            
            Button("Step +1s"){
                simVM.step()
            }
            
            Button("Reset"){
                simVM.reset()
            }
            
        }
    }
}

#Preview {
    SpaceSceneView()
}
