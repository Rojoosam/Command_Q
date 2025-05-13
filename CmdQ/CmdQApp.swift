//
//  CmdQApp.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 10/05/25.
//

import SwiftUI

@main
struct CmdQApp: App {
    @StateObject private var session = Session()
    
    var body: some Scene {
        WindowGroup {
            if session.isLoggedIn {
                //MapView()
                MainTabView()
            } else {
                LoginView().environmentObject(session)
            }
        }
    }
}
