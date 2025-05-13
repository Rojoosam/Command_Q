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
                            destination: HomeView()
                                .navigationBarHidden(true),
                            isActive: $navigateToHome
            ) {
                EmptyView()
            }
            .hidden()
            NavigationLink(
                            destination: PayMethodView()
                                .navigationBarHidden(false),
                            isActive: $navigateToPayMethod
            ) {
                EmptyView()
            }
            .hidden()
            
            HeaderView(title: "BBVA")
            
            
            VStack {
                Text("Bienvenido 'Cliente'!")
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                
                Button(action: handleLogin) {
                                Text("Login")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.lightBlueBBVA)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                }
                
                HStack {
                    Spacer()
                    NavigationLink(destination: RoadmapView()) {
                        Text("¿Quieres ayuda para registrar tu empresa?")
                            .foregroundColor(Color.azulBBVA)
                            .multilineTextAlignment(.trailing)
                            .lineLimit(2)
                            .frame(
                                width: UIScreen.main.bounds.width * 0.75,
                                alignment: .trailing
                            )
                    }
                }
                .padding(.top, 8)
                
                Spacer(minLength: 35)
                
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
        .navigationBarItems(leading: CustomBackHeaderButton(colorFlecha: .clear))
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
