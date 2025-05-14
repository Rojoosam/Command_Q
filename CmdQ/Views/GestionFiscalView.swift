import SwiftUI
import UniformTypeIdentifiers

struct GestionFiscalView: View {
    @State private var selectedFileURL: URL?
    @State private var isFileImporterPresented = false

    struct GastoDeducible: Identifiable {
        let id = UUID()
        let nombre: String
        let monto: Double
        let categoria: String
    }

    let gastosEjemplo: [GastoDeducible] = [
        .init(nombre: "Pago de servicios de internet", monto: 750.00, categoria: "Servicios"),
        .init(nombre: "Gasolina para reparto", monto: 2100.00, categoria: "Transporte"),
        .init(nombre: "Productos de limpieza", monto: 450.00, categoria: "Insumos"),
        .init(nombre: "Honorarios contables", monto: 1500.00, categoria: "Profesionales"),
        .init(nombre: "Publicidad en redes sociales", monto: 3700.00, categoria: "Marketing")
    ]

    var totalDeducible: Double {
        gastosEjemplo.reduce(0) { $0 + $1.monto }
    }

    var body: some View {
        VStack {
            HeaderView(title: "Gestión Fiscal")

            ScrollView {
                VStack(spacing: 28) {
                    // Subir factura
                    VStack(alignment: .leading, spacing: 16) {
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

                        Text(selectedFileURL?.lastPathComponent ?? "No se ha seleccionado ningún archivo.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    // Gastos deducibles
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Gastos deducibles")
                            .font(.headline)

                        ForEach(gastosEjemplo) { gasto in
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

                    // Resumen del mes
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Resumen del mes")
                            .font(.headline)

                        Text("Total deducible")
                            .font(.subheadline)

                        Text("$\(String(format: "%.2f", totalDeducible)) MXN")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.greenBBVA)

                        ProgressView(value: 0.65)
                            .accentColor(.green)

                        Text("65% del límite mensual utilizado")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)

                    // Botón para generar reporte
                    Button(action: {
                        // Acción para generar reporte fiscal
                    }) {
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
                }
                .padding()
            }
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
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackHeaderButton(colorFlecha: .white))
    }
}

#Preview {
    NavigationView {
        GestionFiscalView()
    }
}
