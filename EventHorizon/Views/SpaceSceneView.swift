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
                    HStack(spacing: 20){
                        ClockView(title: "Earth Time", time: simVM.earthTime)
                        ClockView(title: "Traveler Time", time: simVM.travelerTime)
                    }
                    
                    Spacer()
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
            Text("Velocity: \(String(format: "%.2f", simVM.velocityFractionOfC * 100))% Speed of Light")
                .font(.body)
                .foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom))
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.blue.opacity(0.2))
                        .overlay{
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(.blue)
                        }
                }
            
            Slider(
                value: $simVM.velocityFractionOfC,
                in: 0...PhysicalLimits.maxVelocityFractionOfC
            )
        }
        .padding(.horizontal)
    }
    
    private var controlPannel: some View{
        HStack(spacing: 28){
            
            if simVM.mode == .running{
                Button(""){
                    simVM.paused()
                }
                .buttonStyle(CustomButtonStyle(image: "pause"))
            }else{
                Button(""){
                    simVM.resume()
                }
                .buttonStyle(CustomButtonStyle(image: "play"))
            }
            
            
            
            Button(""){
                simVM.step()
            }
            .buttonStyle(CustomButtonStyle(image: "plus"))
            
            Button("Reset"){
                simVM.reset()
            }
            .buttonStyle(CustomButtonStyle(image: "arrow.clockwise"))
            
        }
    }
}

#Preview {
    SpaceSceneView()
}
