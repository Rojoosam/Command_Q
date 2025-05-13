//
//  GestionFiscalView.swift
//  CmdQ
//
//  Created by Alumno on 13/05/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct GestionFiscalView: View {
    @State private var selectedFileURL: URL?
    @State private var isFileImporterPresented = false

    // Ejemplo de datos estáticos
    let gastosEjemplo: [GastoDeducible] = [
        GastoDeducible(nombre: "Pago de servicios de internet", monto: 750.00, categoria: "Servicios"),
        GastoDeducible(nombre: "Gasolina para reparto", monto: 2_100.00, categoria: "Transporte"),
        GastoDeducible(nombre: "Productos de limpieza", monto: 450.00, categoria: "Insumos"),
        GastoDeducible(nombre: "Honorarios contables", monto: 1_500.00, categoria: "Profesionales"),
        GastoDeducible(nombre: "Publicidad en redes sociales", monto: 3_700.00, categoria: "Marketing")
    ]

    // Modelo para gastos simulados
    struct GastoDeducible {
        let nombre: String
        let monto: Double
        let categoria: String
    }

    var body: some View {

        VStack {
            HeaderView(title: "Gestión Fiscal")

            ScrollView {
                VStack(spacing: 28) {
                    // Sección: Carga de factura
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Subir factura electrónica")
                            .font(.headline)

                        Button(action: {
                            isFileImporterPresented = true
                        }) {
                            HStack {
                                Image(systemName: "tray.and.arrow.up.fill")
                                Text("Seleccionar archivo")
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.lightBlueBBVA)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }

                        if let fileName = selectedFileURL?.lastPathComponent {
                            Text("📄 \(fileName)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        } else {
                            Text("No se ha seleccionado ningún archivo.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }

                    // Sección: Validación fiscal (simulada)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Estado del CFDI")
                            .font(.headline)

                    }

                    ScrollView {


                        VStack(spacing: 16) {


                            // Sección: Carga de factura
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Subir factura electrónica")
                                    .font(.headline)

                                Button(action: {
                                    isFileImporterPresented = true
                                }) {
                                    HStack {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.greenBBVA)
                                        Text("Factura válida ante el SAT")
                                            .foregroundColor(.greenBBVA)
                                            .font(.subheadline)
                                    }
                                }

                                // Sección: Categorías de deducción
                                VStack(alignment: .leading, spacing: 16) {
                                    Text("Gastos deducibles")
                                        .font(.headline)

                                    ForEach(gastosEjemplo, id: \.nombre) { gasto in
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

                                }

                                // Sección: Categorías de deducción
                                VStack(alignment: .leading, spacing: 16) {
                                    Text("Gastos deducibles")
                                        .font(.headline)

                                    ForEach(gastosEjemplo, id: \.nombre) { gasto in
                                        HStack {
                                            Image(systemName: "doc.plaintext")
                                            Text("Generar reporte fiscal")
                                        }
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.azulBBVA)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
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
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: CustomBackHeaderButton(colorFlecha: .white))
                    }
                }
            }
        }
    }
}




#Preview {
    GestionFiscalView()
}

