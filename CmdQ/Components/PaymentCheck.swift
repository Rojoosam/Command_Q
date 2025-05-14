//  PaymentCheck.swift
//  CmdQ

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
    @Binding var completed: Bool

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
        }
    }
}

#Preview {
    PaymentCheckPreview()
}

struct PaymentCheckPreview: View {
    @State private var isProcessing = false
    @State private var completed = false

    var body: some View {
        VStack(spacing: 20) {
            PaymentCheck(isProcessing: $isProcessing, completed: $completed)

            Button(isProcessing ? "Reset" : "Start Processing") {
                if isProcessing {
                    isProcessing = false
                    completed = false
                } else {
                    isProcessing = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation {
                            completed = true
                        }
                    }
                }
            }
            .padding()
            .background(Color.lightBlueBBVA)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }
}
