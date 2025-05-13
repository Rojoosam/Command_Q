//
//  Restaurant.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 12/05/25.
//

import Foundation
import SwiftUI

class Restaurant: Identifiable, ObservableObject, Decodable {
    let id = UUID()
    let name: String
    let location: String
    let isCommandQ: Bool
    @Published var currentSales: Int
    @Published var previousSales: Int

    init(name: String, location: String, isCommandQ: Bool, currentSales: Int = 0, previousSales: Int = 0) {
        self.name = name
        self.location = location
        self.isCommandQ = isCommandQ
        self.currentSales = currentSales
        self.previousSales = previousSales
    }

    var displayName: String {
        name.isEmpty ? "Unavailable" : name
    }

    var percentageChange: Double {
        // Definir cambio según ventas, con rango de -100% a +250%
        if previousSales == 0 {
            return currentSales == 0 ? 0 : 250
        }
        let rawChange = (Double(currentSales - previousSales) / Double(previousSales)) * 100
        return min(max(rawChange, -100), 250)
    }

    var trend: Trend {
        if previousSales == 0 { return .neutral }
        if percentageChange > 0 { return .up }
        if percentageChange < 0 { return .down }
        return .neutral
    }

    enum Trend: String, Decodable {
        case up, down, neutral
    }

    // Decodable manual para soportar clase con init
    enum CodingKeys: String, CodingKey {
        case name, location, isCommandQ, currentSales, previousSales
    }

    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let location = try container.decode(String.self, forKey: .location)
        let isCommandQ = try container.decode(Bool.self, forKey: .isCommandQ)
        let currentSales = try container.decodeIfPresent(Int.self, forKey: .currentSales) ?? 0
        let previousSales = try container.decodeIfPresent(Int.self, forKey: .previousSales) ?? 0
        self.init(name: name, location: location, isCommandQ: isCommandQ, currentSales: currentSales, previousSales: previousSales)
    }
}
