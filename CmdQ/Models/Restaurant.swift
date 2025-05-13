//
//  Restaurant.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 12/05/25.
//

import Foundation

struct Restaurant: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let location: String
    let isCommandQ: Bool
    var currentSales: Int = 0
    var previousSales: Int = 0

    var displayName: String {
        name.isEmpty ? "Unavailable" : name
    }

    var percentageChange: Double {
        guard previousSales > 0 else { return 0 }
        return (Double(currentSales - previousSales) / Double(previousSales)) * 100
    }

    var trend: Trend {
        if previousSales == 0 { return .neutral }
        if percentageChange > 0 { return .up }
        if percentageChange < 0 { return .down }
        return .neutral
    }

    enum Trend {
        case up, down, neutral
    }
}
