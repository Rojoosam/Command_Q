//
//  PayMethodView.swift
//  CmdQ
//
//  Created by alumno on 12/05/25.
//

import SwiftUI

struct PayMethodView: View {
    @State private var navigateToContactless = false
    @State private var navigateToQR = false
    @State private var navigateToLink = false
    @State private var navigateToData = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.azulBBVA
                    .ignoresSafeArea()
                
                /// CONTACTLESS
                NavigationLink(
                    destination: ContactlessPayView(flow: "contactless")
                        .navigationBarHidden(true),
                    isActive: $navigateToContactless
                ) {
                    EmptyView()
                }
                .hidden()
               
                /// QR
                NavigationLink(
                    destination: ContactlessPayView(flow: "qr")
                        .navigationBarHidden(true),
                    isActive: $navigateToQR
                ) {
                    EmptyView()
                }
                .hidden()
                
                /// Link
                NavigationLink(
                    destination: ContactlessPayView(flow: "link")
                        .navigationBarHidden(true),
                    isActive: $navigateToLink
                ) {
                    EmptyView()
                }
                .hidden()
                NavigationLink(
                    destination: ContactlessPayView(flow: "pymeData")
                        .navigationBarHidden(true),
                    isActive: $navigateToData
                ) {
                    EmptyView()
                }
                .hidden()
                
                VStack {
                    HeaderView(title: "Metodo de Págo")
                        .padding(.top, 20)
                    
                    VStack {
                        HStack {
                            MethodButton(systemName: "qrcode", method: "Transferencia con QR", action: handleQR)
                            Spacer()
                            MethodButton(systemName: "creditcard.viewfinder", method: "Tarjeta Contactless", action: handleContactlessPayment)
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            
                            MethodButton(systemName: "link.circle", method: "Link de Tranferencia", action: handleLink)
                            Spacer()
                            MethodButton(systemName: "creditcard.and.123", method: "Datos de Cuenta", action: handleData)
                        }
                        
                        .padding()
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackHeaderButton(colorFlecha: .white))
        }
    }
    // Button generator with custom icon
    func MethodButton(systemName: String, method: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack{
                
                ZStack {
                    Color.white
                        .frame(width: 175, height: 250)
                        .cornerRadius(15)

                    Image(systemName: systemName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(Color.lightBlueBBVA)
                }
                
                Text("\(method)")
                    .foregroundStyle(Color.lightBlueBBVA)
                
            }
        }
    }
    
    private func handleContactlessPayment() {
        navigateToContactless = true
    }
    private func handleQR() {
        navigateToQR = true
    }
    private func handleLink() {
        navigateToLink = true
    }
    private func handleData() {
        navigateToData = true
    }
}

#Preview {
    PayMethodView()
}
