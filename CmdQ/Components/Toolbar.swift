//
//  Toolbar.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 13/05/25.
//

import SwiftUI

struct Toolbar: View {
    @State private var navigateToTaxDeduction: Bool = false
    
    var body: some View {
        HStack {
            NavigationLink(
                            destination: GestionFiscalView(),
                                //.navigationBarHidden(true),
                            isActive: $navigateToTaxDeduction
            ) {
                EmptyView()
            }
            .hidden()
            
            Spacer()
            Button(action: {}) {
                VStack {
                    Image(systemName: "arrow.left.arrow.right.circle")
                        .font(.title2)
                    Text("Transferir")
                        .font(.caption)
                }
            }
            Spacer()
            Button(action: {}) {
                VStack {
                    Image(systemName: "plus")
                        .font(.title2)
                    Text("Oportunidades")
                        .font(.caption)
                }
            }
            Spacer()
            Button(action: handleTaxDeductions) {
                VStack {
                    Image(systemName: "dollarsign.arrow.trianglehead.counterclockwise.rotate.90")
                        .font(.title2)
                    Text("Deducir")
                        .font(.caption)
                }
            }
            Spacer()
            Button(action: {}) {
                VStack {
                    Image(systemName: "ellipsis")
                        .font(.title2)
                    Text("Más")
                        .font(.caption)
                }
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .foregroundColor(.primary)
    }
    
    private func handleTaxDeductions() {
        navigateToTaxDeduction = true
    }
}

#Preview {
    Toolbar()
}
