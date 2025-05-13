//
//  CategoriesView.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 10/05/25.
//

import SwiftUI

import SwiftUI

struct CategoriesView: View {
    private let categories: [Category] = Bundle.main.decode("categories.json")
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    private let headerHeight: CGFloat = 70

    var body: some View {
        ZStack(alignment: .top) {
            HeaderView(title: "Categories")
            VStack {
                ScrollView {
                    VStack (spacing: 16) {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(categories) { category in
                                CategoryCard(category: category)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    }
                }
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}


struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
