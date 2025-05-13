//
//  ContactlessPayView.swift
//  CmdQ
//
//  Created by alumno on 13/05/25.
//

import SwiftUI

struct SlideDownCardView: View {
    var body: some View {
        VStack {
            Image(systemName: "checkmark.arrow.trianglehead.counterclockwise")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(Color.lightBlueBBVA)
        }
        .frame(maxWidth: 100, maxHeight: 100)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(radius: 10)
        .padding(.horizontal, 20)

    }
}


struct ContactlessPayView: View {
    @State private var showCard = false

        var body: some View {
            VStack{
                
                if showCard {
                    SlideDownCardView()
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .zIndex(1)
                }
                
                ZStack {
                    Color.white.ignoresSafeArea()

                    Button("Trigger Slide Down") {
                        withAnimation(.spring()) {
                            showCard = true
                        }
                        
                        // Auto-hide after 3 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation(.spring()) {
                                showCard = false
                            }
                        }
                    }
                    .font(.title)

                }
            }
            .animation(.spring(response: 0.5, dampingFraction: 0.85), value: showCard)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackHeaderButton(colorFlecha: .white))
        }
}

#Preview {
    ContactlessPayView()
}
