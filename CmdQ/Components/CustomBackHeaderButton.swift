//
//  CustomBackButton.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 13/05/25.
//

import SwiftUI

struct CustomBackHeaderButton: View {
    
    @Environment(\.presentationMode) private var modoPresentacion
    var colorFlecha: Color
    @State private var animacionActiva = false

    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.3)) {
                animacionActiva = false
                modoPresentacion.wrappedValue.dismiss()
            }
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(colorFlecha)
                .bold()
                .font(.title3)
                .scaleEffect(animacionActiva ? 0.9 : 0.75)
                .opacity(animacionActiva ? 0.9 : 0.5)
        }
        .padding(.leading, 8)
        .frame(width: 36, height: 36, alignment: .center)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.3)) {
                animacionActiva = true
            }
        }
    }
}
