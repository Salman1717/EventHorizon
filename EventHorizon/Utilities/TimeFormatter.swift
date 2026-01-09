//
//  TimeFormatter.swift
//  EventHorizon
//
//  Created by Salman Mhaskar on 09/01/26.
//

import Foundation

struct TimeFormatter{
    static func format(_ time: TimeInterval) -> String {
        let toatalSeconds = Int(time)
        let seconds = toatalSeconds % 60
        let minutes = (toatalSeconds/60) % 60
        let hours = toatalSeconds / 3600
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        
    }
}
