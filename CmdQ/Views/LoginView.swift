//
//  LoginView.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 10/05/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject private var session: Session
    
    var body: some View {
        VStack {
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
                        print("")
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
        
        Spacer()
        
    }
    
    
    private func handleLogin() {
        session.isLoggedIn = true
    }
    
}





#Preview {
    LoginView().environmentObject(Session())
}
