//
//  QRView.swift
//  CmdQ
//
//  Created by alumno on 13/05/25.
//

import SwiftUI

struct QRView: View {
    var body: some View {
        
        ZStack{
            Color.azulBBVA.edgesIgnoringSafeArea(.all)
           
            VStack(alignment: .center){
                
                Image(systemName: "qrcode")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundStyle(Color.white)
                
                
                Text("Escanea este QR para pagar desde tu dispositivo móvil!")
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 30)
            }
        
        }
        
    }
}

#Preview {
    QRView()
}
