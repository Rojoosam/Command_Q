//
//  Container.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 12/05/25.
//

import SwiftUI

struct AccountCard: View {
    var body: some View {
                HStack {
                    VStack(alignment: .leading, spacing: 50) {
                        Text("CUENTAS EN PESOS")
                            .font(.headline)
                            .foregroundColor(.black)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Cuenta")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("*7612")
                                .font(.subheadline)
                                .italic()
                                .bold()
                                .foregroundColor(Color.goldBBVA)
                        }
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("$240,000")
                            .monospacedDigit()
                            .font(.title)
                            .foregroundColor(.black)
                        Text("Saldo disponible")
                            .font(.subheadline)
                            .italic()
                            .foregroundColor(.black)
                    }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 10)
                .background(
                    Color.white
                        .opacity(0.8)
                        .blur(radius: 0.3)
                        .background(.ultraThinMaterial)
                )
//                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .padding(.horizontal)
    }
}

#Preview {
    AccountCard()
}
