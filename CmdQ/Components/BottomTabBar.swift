//
//  BottomTabBar.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 10/05/25.
//

import SwiftUI

enum Tab {
    case home, search, categories, profile
}

struct BottomTabBar: View {
    @Binding var selectedTab: Tab

    var body: some View {
        HStack {
            tabButton(.home, systemIcon: "house", label: "Home")
            Spacer()
            tabButton(.search, systemIcon: "magnifyingglass", label: "Search")
            Spacer()
            tabButton(.categories, systemIcon: "square.grid.2x2", label: "Categories")
            Spacer()
            tabButton(.profile, systemIcon: "person", label: "Profile")
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 16)
        .background(Color.white.shadow(radius: 2))
    }

    private func tabButton(_ tab: Tab, systemIcon: String, label: String) -> some View {
        Button(action: { selectedTab = tab }) {
            VStack {
                Image(systemName: systemIcon)
                    .font(.title2)
                Text(label)
                    .font(.caption)
            }
            .foregroundColor(selectedTab == tab ? .azulBBVA : .gray)
        }
    }
}
