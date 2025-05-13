//
//  AppState.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 13/05/25.
//

import SwiftUI

// Rutas posibles
enum Route: Hashable {
    case login
    case home
}

// Estado global
class AppState: ObservableObject {
    @Published var path: [Route] = []
}
