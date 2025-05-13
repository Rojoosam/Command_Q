//
//  RestaurantManager.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 13/05/25.
//
import Foundation

class RestaurantStore: ObservableObject {
    @Published var restaurants: [Restaurant] = []

    func loadData() {
        let decoded: [Restaurant] = Bundle.main.decode("restaurants.json")
        restaurants = decoded
    }

    func simulateRandomSales() {
        for restaurant in restaurants {
            let previous = restaurant.currentSales
            if Int.random(in: 1...6) == 1 {
                restaurant.currentSales += Int.random(in: 0...3)
                print("✅ \(restaurant.location): \(previous) → \(restaurant.currentSales)")
            }
        }
    }

    func checkInterval() {
        for restaurant in restaurants {
            restaurant.previousSales = restaurant.currentSales
            restaurant.currentSales = 0
        }
    }
}
