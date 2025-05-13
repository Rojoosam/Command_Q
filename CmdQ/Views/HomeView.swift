//
//  HomeView.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 10/05/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HeaderView(title: "Home")
            Spacer()
            Text("Home Content")
            Spacer()
            
        }
    }
}

#Preview {
    HomeView()
}
