//
//  DynamicList.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 12/05/25.
//

import SwiftUI

struct DynamicList: View {
    @State private var restaurants: [Restaurant] = []
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var intervalStart = Date()

    var body: some View {
        List {
            Section(header:
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Color.darkBlueBBVA
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Actividad")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("Lugar")
                                    .font(.subheadline)
                                    .italic()
                                    .bold()
                                    .foregroundColor(Color(hex: "#FFD700"))
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text(Date(), style: .time)
                                    .monospacedDigit()
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("Cambio")
                                    .font(.subheadline)
                                    .italic()
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal)
                    }
                }
                .frame(height: 60)
                .listRowInsets(EdgeInsets())
            ) {
                ForEach(sortedRestaurants.prefix(5) + extraIfNeeded) { restaurant in
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(restaurant.location)
                                    .font(.headline)
                                if !restaurant.name.isEmpty {
                                    Text("– \(restaurant.name)")
                                        .font(.headline)
                                }
                            }
                            Text("Restaurant")
                                .font(.subheadline)
                                .italic()
                                .bold()
                                .foregroundColor(Color(hex: "#FFD700"))
                        }
                        Spacer()
                        HStack {
                            Text(String(format: "%.1f%%", restaurant.percentageChange))
                            Text(trendSymbol(for: restaurant.trend))
                                .foregroundColor(color(for: restaurant.trend))
                        }
                    }/*.listRowBackground(
                        RoundedRectangle(cornerRadius: index == 0 ? 0 : 8)
                            .fill(Color.white)
                    )*/
                }
            }
        }
        .onAppear(perform: loadData)
        .onReceive(timer) { _ in
            simulateRandomSales()
            checkInterval()
        }
    }

    private var sortedRestaurants: [Restaurant] {
        restaurants.sorted { $0.percentageChange > $1.percentageChange }
    }

    private var extraIfNeeded: [Restaurant] {
        guard let q = restaurants.first(where: { $0.isCommandQ }),
              !sortedRestaurants.prefix(5).contains(where: { $0.id == q.id }) else { return [] }
        return [q]
    }

    private func trendSymbol(for trend: Restaurant.Trend) -> String {
        switch trend {
        case .up: return "↑"
        case .down: return "↓"
        case .neutral: return "⎯"
        }
    }

    private func color(for trend: Restaurant.Trend) -> Color {
        switch trend {
        case .up: return .green
        case .down: return .red
        case .neutral: return .gray
        }
    }

    private func loadData() {
    #if DEBUG
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            self.restaurants = [
                Restaurant(name: "Commedor Q", location: "Patria", isCommandQ: true, currentSales: 50, previousSales: 40),
                Restaurant(name: "", location: "Centro", isCommandQ: false, currentSales: 30, previousSales: 20),
                Restaurant(name: "", location: "Zapopan", isCommandQ: false, currentSales: 60, previousSales: 50),
                Restaurant(name: "", location: "Oblatos", isCommandQ: false, currentSales: 55, previousSales: 45),
                Restaurant(name: "", location: "Miravalle", isCommandQ: false, currentSales: 10, previousSales: 17),
                Restaurant(name: "", location: "Minerva", isCommandQ: false, currentSales: 9, previousSales: 22),
            ]
            return
        }
    #endif
        self.restaurants = Bundle.main.decode("restaurants.json")
    }

    private func simulateRandomSales() {
        for i in restaurants.indices {
            if Int.random(in: 1...6) == 1 { // Rough 1s–6s chance
                restaurants[i].currentSales += Int.random(in: 0...3)
            }
        }
    }

    private func checkInterval() {
        if Date().timeIntervalSince(intervalStart) >= 10 { // Cambiar a 600
            for i in restaurants.indices {
                restaurants[i].previousSales = restaurants[i].currentSales
                restaurants[i].currentSales = 0
            }
            intervalStart = Date()
        }
    }
}


#Preview {
    DynamicList()
}
