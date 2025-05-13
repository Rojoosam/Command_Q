//
//  MainTabView.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 10/05/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:
                    HomeView()
                case .search:
                    SearchView()
                case .categories:
                    CategoriesView()
                case .profile:
                    ProfileView()
                }
            }
            BottomTabBar(selectedTab: $selectedTab)
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 0)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    MainTabView()   
}
