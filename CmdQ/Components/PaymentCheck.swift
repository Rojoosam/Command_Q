//  PaymentCheck.swift
//  CmdQ
//
//  Created by Alumno on 13/05/25.
//

import SwiftUI

struct ConditionalSymbolEffect: ViewModifier {
    var apply: Bool

    func body(content: Content) -> some View {
        if apply {
            content.symbolEffect(.rotate.counterClockwise, options: .repeating)
        } else {
            content
        }
    }
}

struct PaymentCheck: View {
    @Binding var isProcessing: Bool
    @State private var completed = false

    var body: some View {
        VStack {
            Image(systemName: completed ? "checkmark.circle.fill" : "arrow.counterclockwise.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(completed ? .greenBBVA : .lightBlueBBVA)
                .modifier(ConditionalSymbolEffect(apply: isProcessing && !completed))
                .contentTransition(
                    .symbolEffect(.replace.magic(fallback: .downUp.wholeSymbol), options: .nonRepeating)
                )
                .onChange(of: isProcessing) { newValue in
                    if newValue {
                        completed = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation {
                                completed = true
                            }
                        }
                    } else {
                        completed = false
                    }
                }
        }
    }
}


#Preview {
    PaymentCheckPreview()
}

struct PaymentCheckPreview: View {
    @State private var isProcessing = false

    var body: some View {
        VStack(spacing: 20) {
            PaymentCheck(isProcessing: $isProcessing)

            Button(isProcessing ? "Reset" : "Start Processing") {
                isProcessing.toggle()
            }
            .padding()
            .background(Color.lightBlueBBVA)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }
}
