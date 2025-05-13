//
//  GaugeView.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 12/05/25.
//

import SwiftUI

struct GaugeView: View {
    @ObservedObject var store: RestaurantStore

    var body: some View {
        let values = store.restaurants.map { $0.percentageChange }
        let minValue = values.min() ?? 0
        let maxValue = values.max() ?? 100
        let comedorQ = store.restaurants.first(where: { $0.isCommandQ })?.percentageChange ?? 0

        return VStack {
            Text("Posición en el mercado")
                .font(.title)
                .bold()
            Text("Mi PyME vs Top 5 en el Sector")
                .font(.subheadline)
                .italic()
                .foregroundColor(Color.goldBBVA)
            ZStack {
                Gauge(value: comedorQ, in: minValue...maxValue) {
                    Text("Comedor Q")
                } currentValueLabel: {
                    Text(String(format: "%.1f", comedorQ))
                } minimumValueLabel: {
                    Text(String(format: "%.1f", minValue))
                } maximumValueLabel: {
                    Text(String(format: "%.1f", maxValue))
                }
                .gaugeStyle(.accessoryCircular)
                .tint(Gradient(stops: [
                    .init(color: .red, location: 0.0),
                    .init(color: .gray, location: 0.5),
                    .init(color: Color.azulBBVA, location: 1.0)
                ]))
                .scaleEffect(3)
            }
            .frame(width: 200, height: 200)
        }
    }
}
