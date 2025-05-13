//
//  GaugeView.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 12/05/25.
//

import SwiftUI

struct GaugeView: View {
    @Binding var restaurants: [Restaurant]

    var body: some View {
        let values = restaurants.map { $0.percentageChange }
        let minValue = values.min() ?? 0
        let maxValue = values.max() ?? 100
        let comedorQ = restaurants.first(where: { $0.isCommandQ })?.percentageChange ?? 0

        return VStack {
            Text("Posición en el mercado")
                .font(.headline)
            Text("Mi PyME vs Top 5 en el Sector")

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
            .frame(width: 200, height: 200)
        }
    }
}
