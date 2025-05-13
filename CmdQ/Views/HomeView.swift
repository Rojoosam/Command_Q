//
//  HomeView.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 10/05/25.
//

import SwiftUI

struct HomeView: View {
    @State private var restaurants: [Restaurant] = []
    var body: some View {
        HeaderView(title: "Home")
        Toolbar()
            ScrollView {
                VStack {
                    Container()
                        .padding(.top, 12)
                    GaugeView(restaurants: $restaurants)
                        .padding()
                    DynamicList(restaurants: $restaurants)
                }
                .padding(.horizontal)
            }
            .onAppear {
                loadData()
            }
        }
    
    private func loadData() {
    #if DEBUG
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            let demoRestaurants = [
                Restaurant(name: "Commedor Q", location: "Patria", isCommandQ: true, currentSales: 50, previousSales: 40),
                Restaurant(name: "", location: "Centro", isCommandQ: false, currentSales: 30, previousSales: 20),
                Restaurant(name: "", location: "Zapopan", isCommandQ: false, currentSales: 60, previousSales: 50),
                Restaurant(name: "", location: "Oblatos", isCommandQ: false, currentSales: 55, previousSales: 45),
                Restaurant(name: "", location: "Miravalle", isCommandQ: false, currentSales: 10, previousSales: 17),
                Restaurant(name: "", location: "Minerva", isCommandQ: false, currentSales: 9, previousSales: 22),
            ]
            restaurants.removeAll()
            restaurants.append(contentsOf: demoRestaurants)
            return
        }
    #endif
        let decoded: [Restaurant] = Bundle.main.decode("restaurants.json")
        restaurants.removeAll()
        restaurants.append(contentsOf: decoded)
    }
}

#Preview {
    HomeView()
}
