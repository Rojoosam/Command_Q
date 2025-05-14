//
//  AnnouncementCard.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 13/05/25.
//

import SwiftUI

/// A removable announcement card styled for BBVA.
struct LoginCard: View {
    /// Binding to control visibility of the card
    @Binding var isVisible: Bool

    var body: some View {
        if isVisible {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 8) {
                    // Title or icon
                    HStack(spacing: 8) {
                        Image(systemName: "megaphone.fill")
                            .foregroundColor(.white)
                        Text("Olvídate de gestionar una terminal para vender en tu negocio")
                            .font(.headline)
                            .foregroundColor(.white)
                    }

                    // Main message with bold and colored substrings
                    (
                        Text("Genera una cuenta en la app BBVA desde tu celular y sigue las instrucciones")
                            .foregroundColor(.white)
                        + Text("\n¡Así empezarás tu venta más rápido! Hazlo Hoy")
                            .foregroundColor(.white)
                            
                    )

                    // Call to action, aligned to the right
                    
                    NavigationLink(destination: RoadmapView()) {
                        Text("Conoce más")
                            .foregroundColor(.lightBlueBBVA)
                                                .fontWeight(.semibold)
                                        }
                    
                }

                Spacer()

                // Close button
                Button(action: {
                    withAnimation {
                        isVisible = false
                    }
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding(8)
                }
            }
            .padding()
            .background(Color.darkBlueBBVA)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
            .padding(.horizontal)
            .transition(.move(edge: .top).combined(with: .opacity))
        }
    }
}

// MARK: - Preview
struct LoginCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            LoginCard(isVisible: .constant(true))
        }
        .background(Color(.systemBackground))
    }
}
