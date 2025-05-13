//
//  RestaurantRow.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 13/05/25.
//
import SwiftUI

struct RestaurantRow: View {
    @ObservedObject var restaurant: Restaurant
    let isFirst: Bool
    let isLast: Bool
    
    var body: some View {
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
                        .foregroundColor(trendColor(for: restaurant.trend))
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(isFirst ? 0 : 8)
            
            if !isLast {
                Divider().padding(.horizontal)
            }
        }
        .padding(.bottom, 4)
    }
    
}

private func trendSymbol(for trend: Restaurant.Trend) -> String {
    switch trend {
    case .up:      return "↑"
    case .down:    return "↓"
    case .neutral: return "⎯"
    }
}

private func trendColor(for trend: Restaurant.Trend) -> Color {
    switch trend {
    case .up:      return .greenBBVA
    case .down:    return .red
    case .neutral: return .gray
    }
}
