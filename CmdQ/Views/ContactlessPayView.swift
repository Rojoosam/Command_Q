import SwiftUI
import UIKit

/// Enum para flujos de pago
enum PaymentFlow: Hashable {
  case qr, contactless, link, pymeData
}


struct SlideDownCardView: View {
    @Binding var isProcessing: Bool
    @Binding var completed: Bool

       var body: some View {
           PaymentCheck(isProcessing: $isProcessing, completed: $completed)
               .padding()
               .background(.ultraThinMaterial)
               .cornerRadius(16)
               .shadow(radius: 10)
               .padding(.horizontal, 20)
               .transition(.move(edge: .top).combined(with: .opacity))
               .zIndex(1)
       }
}
 

/// Vista para métodos de pago con comportamientos dinámicos según el flujo
struct ContactlessPayView: View {
    let flow: String

    @State private var navigateToLogin = false
    @State private var showCard = false
    @State private var amountInput: String = ""
    @State private var isProcessing = false
    @State private var completed = false
    @State private var selectedOption: String? = nil

    @State private var showConfirmSheet = false
    @State private var showLinkToast = false
    @State private var showPymeSheet = false

    private let columns = [GridItem(), GridItem(), GridItem()]

    var body: some View {
        VStack {
            
            Spacer(minLength: 100)
            if flow == "contactless" && showCard {
                SlideDownCardView(isProcessing: $isProcessing, completed: $completed)
            }

            /* Animación solo para contactless
            if flow == "contactless" && showCard {
                SlideDownCardView()
                    .zIndex(1)
            }
             */

            Spacer(minLength: 100)
            
            
            

            // Solo mostrar botones si es contactless
            if flow == "contactless" {
                HStack(spacing: 20) {
                    Button("Débito") { selectedOption = "Débito" }
                        .styleOption(selectedOption == "Débito")
                    Button("Crédito") { selectedOption = "Crédito" }
                        .styleOption(selectedOption == "Crédito")
                }
                .frame(maxWidth: .infinity)
            }

            // Monto siempre visible
            Text("$\(amountInput)")
                .font(.largeTitle)
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1))
                .padding()

            // Teclado numérico
            LazyVGrid(columns: columns) {
                ForEach(1...9, id: \.self) { value in
                    numberButton("\(value)")
                }
            }
            HStack {
                numberButton(".")
                numberButton("0").padding(.horizontal, 42)
                numberButton("delete.backward")
            }
            .padding(.vertical)

            // Botón Confirmar
            Button("Confirmar") {
                confirmAction()
            }
            .padding()
            .font(.title)
            .foregroundColor(.white)
            .background(Color.azulBBVA)
            .cornerRadius(25)
            .frame(width: 300, height: 50)
            .padding(.bottom)
        }
        .padding(.horizontal, 24)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackHeaderButton(colorFlecha: Color.azulBBVA))
        // Sólo contactless: fullScreenCover a LoginView
        .if(flow == "contactless") {
            $0.fullScreenCover(isPresented: $navigateToLogin) {
                LoginView()
            }
        }
        // Sheet para QR: aquí mostramos tu QRView
        .sheet(isPresented: $showConfirmSheet) {
            QRView()
        }
        // Sheet para PymeData
        .sheet(isPresented: $showPymeSheet) {
            VStack(spacing: 16) {
                Text("Datos para tu PyME").font(.title2).bold()
                Text("CLABE: 012345678901234567")
                Text("Cuenta: 1234567890")
                Text("Tarjeta: 4111 1111 1111 1111")
                Spacer()
            }
            .padding()
        }
        // Toast para Link
        .overlay(
            Group {
                if showLinkToast {
                    Text("Link copiado al portapapeles")
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut, value: showLinkToast),
            alignment: .top
        )
    }

    // MARK: - Acciones
    private func confirmAction() {
        switch flow {
        case "contactless":
                            withAnimation(.spring()) {
                                showCard = true
                                isProcessing = true
                                completed = false
                            }

                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                withAnimation {
                                    completed = true
                                }
                            }

                            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                                withAnimation(.spring()) {
                                    showCard = false
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    handleLogin()
                                }
                            }
                        
        case "qr":
            showConfirmSheet = true
        case "link":
            UIPasteboard.general.string = amountInput
            withAnimation { showLinkToast = true }
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                withAnimation { showLinkToast = false }
                handleLogin()
            }
        case "pymeData":
            showPymeSheet = true
        default:
            break
        }
    }

    private func handleLogin() {
        navigateToLogin = true
    }

    // MARK: - Helpers
    private func numberButton(_ number: String) -> some View {
        Button(action: {
            switch number {
            case "delete.backward":
                if !amountInput.isEmpty { amountInput.removeLast() }
            case ".":
                if !amountInput.contains(".") { amountInput.append(".") }
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

// MARK: –– ViewModifier auxiliar para condicionar modificadores
private extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// MARK: - Button Style Extension
private extension Button where Label == Text {
    func styleOption(_ selected: Bool) -> some View {
        self
            .padding()
            .font(.title2)
            .foregroundStyle(.white)
            .background(selected ? Color.green : Color.gray)
            .cornerRadius(25)
            .frame(width: 140, height: 50)
    }
}

// MARK: - Previews
#Preview {
    Group {
        ContactlessPayView(flow: "contactless")
        ContactlessPayView(flow: "qr")
        ContactlessPayView(flow: "link")
        ContactlessPayView(flow: "pymeData")
    }
}
