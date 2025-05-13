//
//  PayMethodView.swift
//  CmdQ
//
//  Created by alumno on 12/05/25.
//

import SwiftUI

struct PayMethodView: View {
    @State private var navigateToContactless = false
    
    var body: some View {
        ZStack {
            Color.azulBBVA
                .ignoresSafeArea()

            NavigationLink(
                            destination: ContactlessPayView()
                                .navigationBarHidden(true),
                            isActive: $navigateToContactless
            ) {
                EmptyView()
            }
            .hidden()
            
            VStack {
                HeaderView(title: "Metodo de Págo")
                    .padding(.top, 20)

                VStack {
                    HStack {
                        MethodButton(systemName: "qrcode", method: "Transferencia con QR", action: {})
                        Spacer()
                        MethodButton(systemName: "creditcard.viewfinder", method: "Tarjeta Contactless", action: handleContactlessPayment)
                    }
                    .padding(.horizontal)

                    HStack {
                        
                        MethodButton(systemName: "link.circle", method: "Link de Tranferencia", action: {})
                        Spacer()
                        MethodButton(systemName: "creditcard.and.123", method: "Datos de Cuenta", action: {})
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
}

#Preview {
    PayMethodView()
}
