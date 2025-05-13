//
//  HomeView.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 10/05/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var store = RestaurantStore()
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var intervalStart = Date()
    
    var body: some View {
        
        HeaderView(title: "Home")
        
        Toolbar()
            ScrollView {
                VStack {
                    Container()
                        .padding(.top, 12)
                    GaugeView(store: store)
                        .padding()
                    DynamicList(store: store)
                }
                .padding(.horizontal)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackHeaderButton(colorFlecha: .clear))
            .onAppear {
                copyJSONFilesToDocuments()
                loadData()
            }
    }
    
    private func copyJSONFilesToDocuments() {
        let fileManager = FileManager.default
        let fileNames = ["categories", "restaurants"]
        
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("❌ No se pudo encontrar el directorio Documents")
            return
        }

        for fileName in fileNames {
            let destinationURL = documentsURL.appendingPathComponent("\(fileName).json")

            // Eliminar archivo existente si ya existe
            if fileManager.fileExists(atPath: destinationURL.path) {
                do {
                    try fileManager.removeItem(at: destinationURL)
                    print("✅ Archivo existente \(fileName).json removido de Documents")
                } catch {
                    print("❌ Error al eliminar \(fileName).json: \(error)")
                }
            }

            // Obtener la URL del archivo dentro del bundle
            guard let sourceURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
                print("❌ No se encontró \(fileName).json en el bundle")
                continue
            }

            // Copiar el archivo al Documents
            do {
                try fileManager.copyItem(at: sourceURL, to: destinationURL)
                print("✅ Archivo \(fileName).json copiado a Documents")
            } catch {
                print("❌ Error al copiar \(fileName).json: \(error)")
            }
        }
    }
    
    private func loadData() {
#if DEBUG
if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
    let demoRestaurants = [
        Restaurant(name: "Commedor Q", location: "Patria", isCommandQ: true, currentSales: 50, previousSales: 40),
        Restaurant(name: "", location: "Centro", isCommandQ: false, currentSales: 30, previousSales: 20),
        Restaurant(name: "", location: "Zapopan", isCommandQ: false, currentSales: 60, previousSales: 50),
        Restaurant(name: "", location: "Oblatos", isCommandQ: false, currentSales: 55, previousSales: 45),
        Restaurant(name: "", location: "Miravalle", isCommandQ: false, currentSales: 10, previousSales: 17),
        Restaurant(name: "", location: "Minerva", isCommandQ: false, currentSales: 9, previousSales: 22),
    ]
    store.restaurants = demoRestaurants
    return
}
#endif

// Cargar siempre el JSON desde Documents
let fileManager = FileManager.default
guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
    print("❌ No se pudo encontrar el directorio Documents")
    return
}
let restaurantsURL = documentsURL.appendingPathComponent("restaurants.json")
do {
    let data = try Data(contentsOf: restaurantsURL)
    let decoded = try JSONDecoder().decode([Restaurant].self, from: data)
    store.restaurants = decoded
} catch {
    print("❌ Error al cargar restaurants.json:", error)
}
    }
}
    

#Preview {
    HomeView()
}
