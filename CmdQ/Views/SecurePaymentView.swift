//
//  SecurePaymentView.swift
//  CmdQ
//
//  Created by alumno on 13/05/25.
//

import SwiftUI
import LocalAuthentication

struct SecurePaymentView: View {
    @State private var isUnlocked = false
    @State private var showError = false
    @State private var didAttemptUnlock = false
    
    var body: some View {
        Group {
            if isUnlocked {
                PayMethodView()
            } else {
                VStack {
                    Text("🔒 Authenticating...")
                        .font(.title3)
                        .padding()
                }
            }
        }
        .onAppear {
            if !didAttemptUnlock {
                authenticate()
                didAttemptUnlock = true
            }
        }
        .alert(isPresented: $showError) {
            Alert(
                title: Text("Authentication Failed"),
                message: Text("Face ID failed or was canceled."),
                dismissButton: .default(Text("Retry"), action: {
                    didAttemptUnlock = false //Reset to allow retry
                })
            )
        }
    }
    
    private func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to access Payment Method View"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.showError = true
                    }
                }
            }
        } else {
            // Biometric not available or not enrolled
            print("Biometry not available:", error?.localizedDescription ?? "Unknown error")
            self.showError = true
        }
    }
}
