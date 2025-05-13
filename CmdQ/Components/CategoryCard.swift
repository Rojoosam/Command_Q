//
//  CategoryCard.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 10/05/25.
//

import SwiftUI

struct CategoryCard: View {
    let category: Category

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: category.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.azulBBVA)

            Text(category.title)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .lineLimit(2)
        }
        .padding()
        .frame(width: 150, height: 150)         
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}
