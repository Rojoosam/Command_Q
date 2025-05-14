//
//  AnnouncementCard.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 13/05/25.
//

import SwiftUI

/// A removable announcement card styled for BBVA.
struct AnnouncementCard: View {
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
                        Text("Tu PyME corre peligro")
                            .font(.headline)
                            .foregroundColor(.white)
                    }

                    // Main message with bold and colored substrings
                    (
                        Text("Detectamos que las ventas de tu PyME se encuentran ")
                            .foregroundColor(.white)
                        + Text("por debajo de la media")
                            .bold()
                            .foregroundColor(Color(red: 1.00, green: 0.40, blue: 0.40))
                        + Text(" en relación a tu competencia.")
                            .foregroundColor(.white)
                    )

                    // Call to action, aligned to the right
                    
                        Text("Conoce más")
                            .foregroundColor(.lightBlueBBVA)
                            .fontWeight(.semibold)
                    
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
struct AnnouncementCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            AnnouncementCard(isVisible: .constant(true))
        }
        .background(Color(.systemBackground))
    }
}
