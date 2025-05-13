//
//  Untitled.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 10/05/25.
//

import SwiftUI

extension Color {
    static let darkBlueBBVA = Color(red: 22/255, green: 38/255, blue: 73/255)
    static let lightBlueBBVA = Color(red: 61/255, green: 136/255, blue: 192/255)
    static let azulBBVA = Color(red: 19/255, green: 49/255, blue: 96/255)
    static let greenBBVA = Color(red: 77/255, green: 170/255, blue: 103/255)

    static var headerGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.azulBBVA, .lightBlueBBVA]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
