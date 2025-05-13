//
//  SecureHomeView.swift
//  CmdQ
//
//  Created by alumno on 13/05/25.
//
import SwiftUI
import LocalAuthentication

struct SecureHomeView: View {
    @State private var isUnlocked = false
    @State private var showError = false
    @State private var didAttemptUnlock = false
    
    var body: some View {
        Group {
            if isUnlocked {
                HomeView()
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
                    didAttemptUnlock = false // Reset to allow retry
                })
            )
        }
    }
    
    private func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to access Home"
            
        }
    }
}
