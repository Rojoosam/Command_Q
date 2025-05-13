//
//  Untitled.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 10/05/25.
//

import SwiftUI

struct Theme {
    static let primaryColor = Color(.blue)
    static let secondaryColor = Color(.purple)
    static let accentColor = Color(.white)

    // Gradient
    static var headerGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [primaryColor, secondaryColor]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
