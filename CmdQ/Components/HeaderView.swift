//
//  HeaderView.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 10/05/25.
//

import SwiftUI

import SwiftUI

struct HeaderView: View {
    var title: String
    private let fixedHeight: CGFloat = 70

    var body: some View {
        ZStack {
            Theme.headerGradient
                .ignoresSafeArea(edges: .top)
            HStack {
                Text(title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
        }
        .frame(height: fixedHeight)
        .zIndex(1)
    }
}

#Preview {
    HeaderView(title: "Ejemplo")
}
