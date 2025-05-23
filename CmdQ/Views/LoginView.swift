//
//  LoginView.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 10/05/25.
//

// LoginView.swift

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var session: Session
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigateToHome = false
    @State private var navigateToPayMethod = false
    
    var body: some View {
        VStack {
            NavigationLink(
                            destination: SecureHomeView()
                                .navigationBarHidden(true),
                            isActive: $navigateToHome
            ) {
                EmptyView()
            }
            .hidden()
            NavigationLink(
                            destination: SecurePaymentView()
                                .navigationBarHidden(false),
                            isActive: $navigateToPayMethod
            ) {
                EmptyView()
            }
            .hidden()
            
            HeaderView(title: "BBVA")
            
            
            VStack {
                Text("¡Bienvenido Javier!")
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                
                Button(action: handleLogin) {
                                Text("Login")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.lightBlueBBVA)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .padding(.top, 8)
                }
                
                //Spacer(minLength: 5)
                LoginCard(isVisible: .constant(true)).padding(.top, 15)

               
                
                Spacer(minLength: 45)
                
                HStack{
                    Button(action: {
                        print("")
                    }) {
                        Image(systemName: "qrcode")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.azulBBVA)
                    }.background(Color.lightBlueBBVA).cornerRadius(15)
                    
                    
                    Button(action: {
                        print("")
                    }) {
                        Image(systemName: "lock.shield.fill")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.azulBBVA)
                    }.background(Color.lightBlueBBVA)
                        .cornerRadius(15)
                    
                    
                    Button(action: {
                        print("")
                    }) {
                        Image(systemName: "sos.circle.fill")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.azulBBVA)
                    }.background(Color.lightBlueBBVA)
                        .cornerRadius(15)
                    
                    
                    Button(action: {
                        handlePayment()
                    }) {
                        Image(systemName: "creditcard.viewfinder")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.azulBBVA)
                    }.background(Color.lightBlueBBVA)
                        .cornerRadius(15)
                }
            }.padding()
        }
        .navigationBarBackButtonHidden(true)
        Spacer()
    }
    
    
    private func handleLogin() {
            session.isLoggedIn = true
            navigateToHome = true
    }
    private func handlePayment() {
        navigateToPayMethod = true
    }
    
}





#Preview {
    LoginView().environmentObject(Session())
}
