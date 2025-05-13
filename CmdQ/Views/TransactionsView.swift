//
//  GestionFiscalView 2.swift
//  CmdQ
//
//  Created by Alumno on 13/05/25.
//


//
//  GestionFiscalView.swift
//  CmdQ
//
//  Created by Alumno on 13/05/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct TransactionsView: View {
    @State private var selectedFileURL: URL?
    @State private var isFileImporterPresented = false

    var body: some View {

        VStack {
            HeaderView(title: "Historial de Gastos")
        }

        ScrollView {




            VStack(spacing: 16) {   


                // Sección: Categorías de deducción
                VStack(alignment: .leading, spacing: 16) {
                    Text("Gastos recientes")
                        .font(.headline)

                    ForEach(gastosEj, id: \.nombre) { gasto in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(gasto.nombre)
                                    .font(.subheadline)
                                Text("$\(String(format: "%.2f", gasto.monto)) MXN")
                                    .fontWeight(.medium)
                            }
                            Spacer()
                            Text(gasto.categoria)
                                .font(.caption)
                                .padding(6)
                                .background(Color(.systemGray5))
                                .cornerRadius(8)
                        }
                        .padding(.vertical, 4)
                    }
                }

                // Sección: Resumen general
                VStack(alignment: .leading, spacing: 12) {
                    Text("Resumen del mes")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Total deducible")
                            .font(.subheadline)

                        Text("$8,500.00 MXN")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.greenBBVA)
                    }

                    ProgressView(value: 0.65)
                        .accentColor(.green)
                    Text("65% del límite mensual utilizado")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)

                // Botón: Generar reporte
                Button(action: {
                    // Acción: Generar reporte fiscal
                }) {
                    HStack {
                        Image(systemName: "doc.plaintext")
                        Text("Generar reporte fiscal")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.azulBBVA)
                    .foregroundColor(.white)
                }

                Spacer()
            }
            .padding()
        }
        .fileImporter(
            isPresented: $isFileImporterPresented,
            allowedContentTypes: [UTType.xml, UTType.pdf],
            allowsMultipleSelection: false
        ) { result in
            switch result {
            case .success(let urls):
                selectedFileURL = urls.first
            case .failure(let error):
                print("Error al seleccionar el archivo: \(error.localizedDescription)")
            }
        }
    }
}

// Modelo para gastos simulados
struct Gasto {
    let nombre: String
    let monto: Double
    let categoria: String
}

// Ejemplo de datos estáticos
let gastosEj: [Gasto] = [
    Gasto(nombre: "Pago de servicios de internet", monto: 750.00, categoria: "Servicios"),
    Gasto(nombre: "Boletos cine", monto: 199.00, categoria: "Entretenimiento"),
    Gasto(nombre: "Productos de limpieza", monto: 450.00, categoria: "Insumos"),
    Gasto(nombre: "Depósito a Rebe", monto: 1_500.00, categoria: "Personal"),
    Gasto(nombre: "Desechables en mayoreo", monto: 1_600.00, categoria: "Insumos")
]

#Preview {
    TransactionsView()
}

