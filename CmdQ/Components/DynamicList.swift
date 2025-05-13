//  DynamicList.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 12/05/25.
//

import SwiftUI

struct DynamicList: View {
    @ObservedObject var store: RestaurantStore
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var intervalStart = Date()

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(spacing: 0) {
                // Encabezado
                HStack {
                    VStack(alignment: .leading) {
                        Text("Actividad")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("Lugar")
                            .font(.subheadline)
                            .italic()
                            .bold()
                            .foregroundColor(Color.goldBBVA)
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
                .padding()
                .background(Color.azulBBVA)

                // Lista de restaurantes con RestaurantRow
                LazyVStack(spacing: 0) {
                    let displayed = sortedRestaurants.prefix(5) + extraIfNeeded
                    ForEach(Array(displayed.enumerated()), id: \.element.id) { index, restaurant in
                        RestaurantRow(
                            restaurant: restaurant,
                            isFirst: index == 0,
                            isLast: index == displayed.count - 1
                        )
                    }
                }
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
            }
            .padding(.horizontal)
        }
        .onReceive(timer) { _ in
            simulateRandomSales()
            checkInterval()
        }
    }

    private var sortedRestaurants: [Restaurant] {
        store.restaurants.sorted { $0.percentageChange > $1.percentageChange }
    }

    private var extraIfNeeded: [Restaurant] {
        guard let q = store.restaurants.first(where: { $0.isCommandQ }),
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

    private func simulateRandomSales() {
        for i in store.restaurants.indices {
            let prev = store.restaurants[i].currentSales
            var next = prev
            if Int.random(in: 1...6) == 1 {
                next += Int.random(in: 0...3)
            }
            store.restaurants[i].previousSales = prev
            store.restaurants[i].currentSales = next
        }
        store.objectWillChange.send()
    }

    private func checkInterval() {
        if Date().timeIntervalSince(intervalStart) >= 30 { // 10 minutes
            for i in store.restaurants.indices {
                store.restaurants[i].previousSales = store.restaurants[i].currentSales
                store.restaurants[i].currentSales = 0
            }
            intervalStart = Date()
        }
    }
}
