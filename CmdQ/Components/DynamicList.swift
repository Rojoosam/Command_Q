//
//  DynamicList.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 12/05/25.
//

import SwiftUI

struct DynamicList: View {
    @Binding var restaurants: [Restaurant]
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

                // Lista de restaurantes con divisiones
                LazyVStack(spacing: 0) {
                    ForEach(Array((sortedRestaurants.prefix(5) + extraIfNeeded).enumerated()), id: \.element.id) { index, restaurant in
                        VStack(spacing: 0) {
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
                                        .foregroundColor(Color.goldBBVA)
                                }
                                Spacer()
                                HStack {
                                    Text(String(format: "%.1f%%", restaurant.percentageChange))
                                    Text(trendSymbol(for: restaurant.trend))
                                        .foregroundColor(color(for: restaurant.trend))
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(index == 0 ? 0 : 8)

                            if index != sortedRestaurants.prefix(5).count + extraIfNeeded.count - 1 {
                                Divider()
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.bottom, 4)
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

    private func simulateRandomSales() {
        for i in restaurants.indices {
            if Int.random(in: 1...6) == 1 {
                restaurants[i].currentSales += Int.random(in: 0...3)
            }
        }
    }

    private func checkInterval() {
        if Date().timeIntervalSince(intervalStart) >= 600 { // 10 minutos
            for i in restaurants.indices {
                restaurants[i].previousSales = restaurants[i].currentSales
                restaurants[i].currentSales = 0
            }
            intervalStart = Date()
        }
    }
}
