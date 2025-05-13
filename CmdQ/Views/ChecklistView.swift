//
//  ChecklistView.swift
//  CmdQ
//
//  Created by Alumno on 12/05/25.
//

import SwiftUI

// MARK: - Enum for TipoPersona

enum TipoPersona: String, CaseIterable, Identifiable {
    case pfae = "Persona Física"
    case moral = "Persona Moral"
    var id: String { rawValue }
}

// MARK: - Checklist Item Model

struct ChecklistItem: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let description: String
    var isCompleted: Bool = false
}

// MARK: - Checklist View

struct ChecklistView: View {
    @State private var tipoPersona: TipoPersona = .pfae
    @State private var items: [ChecklistItem] = []

    var body: some View {
        VStack(spacing: 16) {
            Text("¡Prepárate para formalizar tu negocio!")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 20)

            Picker("Tipo de persona", selection: $tipoPersona) {
                ForEach(TipoPersona.allCases) { tipo in
                    Text(tipo.rawValue).tag(tipo)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            let completedCount = items.filter { $0.isCompleted }.count
            let progress = items.isEmpty ? 0 : CGFloat(completedCount) / CGFloat(items.count)

            VStack {
                CircularProgress(
                    progress: progress,
                    lineWidth: 10,
                    gradient: LinearGradient(colors: [.lightBlueBBVA, .greenBBVA], startPoint: .top, endPoint: .bottom),
                    backgroundColor: .gray.opacity(0.2),
                    fillAxis: .horizontal
                )
                .frame(width: 120, height: 120)

                Text("\(completedCount) de \(items.count) completados")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            ScrollView {
                VStack(spacing: 12) {
                    ForEach($items) { $item in
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(item.isCompleted ? .greenBBVA : .gray)
                                .onTapGesture {
                                    item.isCompleted.toggle()
                                }

                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.title)
                                    .font(.body)
                                    .fontWeight(.semibold)

                                Text(item.description)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemBackground))
                                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }

            Spacer()
        }
        .background(Color(.systemGroupedBackground))
        .onAppear {
            updateChecklist()
        }
        .onChange(of: tipoPersona) {
            updateChecklist()
        }
    }

    // MARK: - Checklist Data Source

    private func updateChecklist() {
        switch tipoPersona {
        case .pfae:
            items = [
                ChecklistItem(title: "Identificación oficial vigente", description: "INE o pasaporte válido. Asegúrate que los datos sean legibles."),
                ChecklistItem(title: "Comprobante de domicilio", description: "Puede ser luz, agua o teléfono. No debe tener más de 3 meses de antigüedad."),
                ChecklistItem(title: "RFC con constancia de situación fiscal", description: "Se obtiene en el portal del SAT. Es obligatorio para actividades empresariales."),
                ChecklistItem(title: "Número de celular vigente", description: "Debe estar activo, ya que lo usarás para validaciones y notificaciones."),
                ChecklistItem(title: "Firma electrónica avanzada (e.firma)", description: "Antes conocida como FIEL. Es tu firma digital y se tramita en el SAT.")
            ]
        case .moral:
            items = [
                ChecklistItem(title: "Formato de Autodeclaratoria", description: "Documento obligatorio para apertura. Descárgalo desde el portal del banco."),
                ChecklistItem(title: "Acta constitutiva de la empresa", description: "Debe incluir el sello del Registro Público de Comercio. Para SAS, contrato social firmado por la Secretaría de Economía."),
                ChecklistItem(title: "Poder notarial de los representantes legales", description: "Documento con sello notarial que les autoriza a firmar contratos y documentos."),
                ChecklistItem(title: "RFC con constancia de situación fiscal", description: "Se obtiene en el portal del SAT, identifica legalmente a tu empresa."),
                ChecklistItem(title: "Número de celular vigente", description: "Debe estar activo para validar identidad de los representantes."),
                ChecklistItem(title: "Identificación oficial de firmantes", description: "INE o pasaporte vigente de cada apoderado legal o firmante autorizado."),
                ChecklistItem(title: "Firma electrónica avanzada (e.firma)", description: "Obligatoria para trámites digitales. Se tramita en el SAT."),
                ChecklistItem(title: "Comprobante de domicilio del negocio", description: "Fiscal y operativo. Debe tener máximo 3 meses de antigüedad.")
            ]
        }
    }
}

#Preview {
    ChecklistView()
}

