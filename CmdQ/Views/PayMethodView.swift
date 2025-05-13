//
//  PayMethodView.swift
//  CmdQ
//
//  Created by alumno on 12/05/25.
//

import SwiftUI

struct PayMethodView: View {
    var body: some View {
        ZStack {
            Color.azulBBVA
                .ignoresSafeArea()

            VStack {
                HeaderView(title: "Metodo de Págo")
                    .padding(.top, 20)

                VStack {
                    HStack {
                        MethodButton(systemName: "qrcode", method: "Transferencia con QR")
                        Spacer()
                        MethodButton(systemName: "creditcard.viewfinder", method: "Tarjeta Contactless")
                    }
                    .padding(.horizontal)

                    HStack {
                        
                        MethodButton(systemName: "link.circle", method: "Link de Tranferencia")
                        Spacer()
                        MethodButton(systemName: "creditcard.and.123", method: "Datos de Cuenta")
                    }
                    
                    .padding()
                }
                .padding(.top, 20)

                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }

    // Button generator with custom icon
    func MethodButton(systemName: String, method: String) -> some View {
        Button(action: {
            print("\(systemName) tapped")
        }) {
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
}

#Preview {
    PayMethodView()
}
