//
//  CmdQApp.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 10/05/25.
//

// CmdQApp.swift

import SwiftUI

@main
struct CmdQApp: App {
    @StateObject private var session  = Session()
    @StateObject private var store    = RestaurantStore()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoginView().navigationBarHidden(true)
            }
            .environmentObject(session)
            .environmentObject(store)
        }
    }
}
