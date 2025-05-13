//
//  ContactlessPayView.swift
//  CmdQ
//
//  Created by alumno on 13/05/25.
//

import SwiftUI

struct SlideDownCardView: View {
    var body: some View {
        VStack {
            Image(systemName: "checkmark.arrow.trianglehead.counterclockwise")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(Color.lightBlueBBVA)
        }
        .padding()
        .frame(maxWidth: 100, maxHeight: 100)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(radius: 10)
        .padding(.horizontal, 20)
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}


struct ContactlessPayView: View {
    @State private var navigateToLogin: Bool = false
    @State private var showCard = false
    @State private var amountInput: String = ""
    @State private var selectedOption: String? = nil
    
    
    let columns = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        VStack() {
            NavigationLink(
                            destination: LoginView(),
                            isActive: $navigateToLogin
            ) {
                EmptyView()
            }
            .hidden()
            
            Spacer(minLength: 100)
            
            if showCard {
                SlideDownCardView()
                    .zIndex(1)
            }
            
            Spacer(minLength: 100)
            
            HStack(spacing: 20) {
                Button("Débito") {
                    selectedOption = "Débito"
                }
                .padding()
                .font(.title2)
                .foregroundStyle(Color.white)
                .background(selectedOption == "Débito" ? Color.green : Color.gray)
                .cornerRadius(25.0)
                .frame(width: 140, height: 50)
                
                Button("Crédito") {
                    selectedOption = "Crédito"
                }
                .padding()
                .font(.title2)
                .foregroundStyle(Color.white)
                .background(selectedOption == "Crédito" ? Color.green : Color.gray)
                .cornerRadius(25.0)
                .frame(width: 140, height: 50)
            }
            .frame(maxWidth: .infinity)
            
            
            Text("$\(amountInput)")
                .font(.largeTitle)
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(style: StrokeStyle(lineWidth: 1)))
                .padding()
            
            LazyVGrid(columns: columns) {
                ForEach(1...9, id: \.self) { value in
                    NumberButton(number: "\(value)")
                }
            }
            
            HStack {
                NumberButton(number: ".").padding(.leading)
                NumberButton(number: "0").padding(.horizontal, 42)
                NumberButton(number: "delete.backward")
                    .padding(.trailing)
                
            }
            .padding(.vertical)
            
            Button("Confirmar") { 
                withAnimation(.spring()) {
                    showCard = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation(.spring()) {
                        showCard = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        handleLogin()
                    }
                }
            }.padding()
                .font(.title)
                .foregroundStyle(Color.white)
                .background(Color.azulBBVA)
                .cornerRadius(25.0)
                .frame(width: 300, height: 50)
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackHeaderButton(colorFlecha: Color.azulBBVA))
        .padding(.horizontal, 24.0)
    }
    
    private func handleLogin() {
        navigateToLogin = true
    }
    
    func NumberButton(number: String) -> some View {
        Button(action: {
            switch number {
            case "delete.backward":
                if !amountInput.isEmpty {
                    amountInput.removeLast()
                }
            case ".":
                if !amountInput.contains(".") {
                    amountInput.append(".")
                }
            default:
                amountInput.append(number)
            }
        }) {
            ZStack {
                Circle()
                    .frame(width: 70, height: 70)
                    .foregroundStyle(Color.lightBlueBBVA)
                
                if number == "delete.backward" {
                    Image(systemName: "delete.backward")
                        .font(.title)
                        .foregroundStyle(.white)
                } else {
                    Text(number)
                        .font(.title)
                        .foregroundStyle(.white)
                }
            }
        }
    }
    
    
}


#Preview {
    ContactlessPayView()
}
