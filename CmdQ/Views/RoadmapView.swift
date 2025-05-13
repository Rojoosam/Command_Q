//
//  RoadmapView.swift
//  CmdQ
//
//  Created by Alumno on 13/05/25.
//

import SwiftUI

struct RoadmapView: View {
    @State private var showSteps = false
    @State private var showBenefits = false

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Encabezado
                VStack(spacing: 8) {
                    Text("Formaliza tu negocio con BBVA")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.azulBBVA)
                        .multilineTextAlignment(.center)

                    Text("Crea tu empresa, accede a herramientas digitales y haz crecer tu PyME con confianza.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.top, 40)

                // Roadmap del proceso
                VStack(alignment: .leading, spacing: 24) {
                    Text("Tu camino a la formalización")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.darkBlueBBVA)

                    ForEach(roadmapSteps.indices, id: \.self) { index in
                        HStack(alignment: .top, spacing: 16) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.lightBlueBBVA)
                                .imageScale(.large)
                            Text(roadmapSteps[index])
                                .font(.body)
                        }
                        .opacity(showSteps ? 1 : 0)
                        .offset(x: showSteps ? 0 : -30)
                        .animation(.easeOut.delay(Double(index) * 0.15), value: showSteps)
                    }
                }

                // Beneficios con animaciones
                VStack(alignment: .leading, spacing: 24) {
                    Text("Beneficios de BBVA para tu negocio")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.azulBBVA)

                    ForEach(beneficios.indices, id: \.self) { index in
                        BenefitCardView(benefit: beneficios[index])
                            .opacity(showBenefits ? 1 : 0)
                            .offset(y: showBenefits ? 0 : 20)
                            .animation(.spring().delay(Double(index) * 0.2), value: showBenefits)
                    }
                }

                // Botón CTA
                Button(action: {
                    // Acción para iniciar proceso o contactar
                }) {
                    Text("Inicia tu proceso")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.azulBBVA)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .onAppear {
            showSteps = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showBenefits = true
            }
        }
    }

    let roadmapSteps = [
        "Reúne tus documentos fiscales y legales",
        "Regístrate en el SAT como PFAE o Persona Moral",
        "Abre tu Cuenta Maestra Pyme en BBVA",
        "Activa servicios digitales y recibe pagos",
        "Accede a soluciones de cobro y crédito"
    ]

    let beneficios = [
        "Sin costo de apertura ni saldo mínimo",
        "Servicios digitales incluidos, sin costo adicional",
        "Tarjeta Débito Negocios incluida",
        "Protección de cheques sin costo",
        "Acceso a terminal punto de venta sin facturación mínima"
    ]
}

struct BenefitCardView: View {
    let benefit: String

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: "star.fill")
                .foregroundColor(.white)
                .padding(10)
                .background(Color.greenBBVA)
                .clipShape(Circle())

            Text(benefit)
                .font(.body)
                .foregroundColor(.primary)

            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}


#Preview {
    RoadmapView()
}
