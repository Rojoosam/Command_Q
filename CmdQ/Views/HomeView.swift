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
    @State private var showAnnouncement = true
    @State private var navigateToLogin: Bool = false

    
    private var shouldShowAnnouncement: Bool {
            let all = store.restaurants
            guard
              let comedorQ = all.first(where: { $0.isCommandQ }),
              !all.isEmpty
            else { return false }

            // Calcula la media de percentageChange del resto
            let total = all.map(\.percentageChange).reduce(0, +)
            let average = total / Double(all.count)
            return comedorQ.percentageChange < average
        }
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing){
            
            NavigationLink(
                            destination: LoginView(),
                            isActive: $navigateToLogin
            ) {
                EmptyView()
            }
            .hidden()
            
                HeaderView(title: "Home")
                
                Button(action: {
                    handleLogin()
                }) {
                    Text("Logout")
                }.foregroundStyle(Color.white)
                .padding()
                .padding(.trailing, 16)
                .zIndex(2)
                        
            }
        
        
            Toolbar()

            ScrollView {
                VStack(spacing: 16) {
                    Container().padding(.top, 12)

                    // 2) sólo si showAnnouncement es true
                    if showAnnouncement {
                        AnnouncementCard(isVisible: $showAnnouncement)
                    }

                    GaugeView(store: store).padding()
                    DynamicList(store: store)
                }
                .padding(.horizontal)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackHeaderButton(colorFlecha: .clear))
            .onAppear {
                copyJSONFilesToDocuments()
                loadData()
                if shouldShowAnnouncement {
                    showAnnouncement = true
                }
            }
            .onReceive(timer) { _ in 
                if shouldShowAnnouncement && !showAnnouncement {
                    showAnnouncement = true
                }
            }
        }
    
    private func handleLogin() {
        navigateToLogin = true
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
