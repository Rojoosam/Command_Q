//
//  PinManager.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 13/05/25.
//

import Foundation
import SwiftUI
import MapKit


// Pin Model
struct Pin: Codable {
    let longitude: String
    let latitude: String
    let color: String
    let message: String
    let name: String
}

// Container
struct NearbyPinsContainer: Codable {
    let nearbyPins: [Pin]
}

// Extracts the response attribute
struct ResponseWrapper: Codable {
    let response: NearbyPinsContainer
}

class PinManager {
    static let shared = PinManager()
    private let fileName = "pins.json"

    /*private init() {
        //copyJSONFileIfNeeded()
        copyJSONFileAlways()
    }*/

    /*
    private func copyJSONFileAlways() {
        let fileManager = FileManager.default
        
        // Get directory's route
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("❌ No se pudo encontrar el directorio Documents")
            return
        }
        
        let destinationURL = documentsURL.appendingPathComponent(fileName)
        
        // If file exists, delete it
        if fileManager.fileExists(atPath: destinationURL.path) {
            do {
                try fileManager.removeItem(at: destinationURL)
                print("✅ Archivo existente removido de Documents")
            } catch {
                print("❌ Error al eliminar archivo existente: \(error)")
            }
        }
        
        // Gets Bundle's url
        guard let sourceURL = Bundle.main.url(forResource: "pins", withExtension: "json") else {
            print("❌ No se encontró pins.json en el bundle")
            return
        }
        
        // Copy bundle --> documents (file)
        do {
            try fileManager.copyItem(at: sourceURL, to: destinationURL)
            print("✅ Archivo pins.json copiado a Documents")
        } catch {
            print("❌ Error al copiar pins.json: \(error)")
        }
    }*/


    // Read pins file
    func loadPins() -> [Pin] {
        let wrapper: ResponseWrapper = Bundle.main.decode("pins.json")
        return wrapper.response.nearbyPins
    }


    // Saves pins
    func savePins(_ pins: [Pin]) {
        let response = ResponseWrapper(response: NearbyPinsContainer(nearbyPins: pins))
        let fileManager = FileManager.default
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentsURL.appendingPathComponent(fileName)
        
        do {
            let data = try JSONEncoder().encode(response)
            try data.write(to: fileURL, options: .atomic)
            print("✅ Pins guardados correctamente en \(fileURL)")
        } catch {
            print("❌ Error al guardar pins.json: \(error)")
        }
    }
    
    // Add-pin
    func addPin(_ pin: Pin) {
        var pins = loadPins()
        pins.append(pin)
        savePins(pins)
    }
    
    // Delete all pins (into simulation app, not the project)
    func clearPins() {
        savePins([])
        print("✅ Todos los pines han sido eliminados.")
    }
}

extension Pin {
    func toLocation() -> Location? {
        guard let lat = Double(latitude),
              let lon = Double(longitude) else { return nil }

        return Location(
            coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon),
            color: Color(.yellow),
            message: message,
            name: name
        )
    }
}

struct Location: Identifiable, Hashable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let color: Color
    let message: String
    let name: String

    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
