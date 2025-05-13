//
//  Map.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 13/05/25.
//

import MapKit
import SwiftUI

struct MapView: View {
    @State private var region: MKCoordinateRegion = .guadalajaraRegion
    @State private var locations: [Location] = []
    @State private var showSheet: Bool = false
    @State private var mapSelection: Location?

    var body: some View {
        HeaderView(title: "Notarías públicas")
        Map(
                    coordinateRegion: $region,
                    annotationItems: locations
        ) { location in
            MapMarker(coordinate: location.coordinate, tint: location.color)
        }
        .mapControls {
            MapCompass()
        }
        .onAppear {
            loadMarkersFromPinManager()
        }
        .onChange(of: mapSelection) { newSelection in
            if let _ = newSelection {
                showSheet = true
            }
        }
        .sheet(isPresented: $showSheet) {
                    if let sel = mapSelection {
                        PinDetailView(location: sel)
                    }
        }
    }

    func loadMarkersFromPinManager() {
        let pins = PinManager.shared.loadPins()
        locations = pins.compactMap { $0.toLocation() }
    }
}

extension MKCoordinateRegion {
    static var guadalajaraRegion: MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 20.6597, longitude: -103.3496),
            latitudinalMeters: 20000,
            longitudinalMeters: 20000
        )
    }
}

struct PinDetailView: View {
    var location: Location

    var body: some View {
        VStack(spacing: 20) {
            Text(location.message)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            
            Circle()
                .fill(location.color)
                .frame(width: 50, height: 50)
                .overlay(Circle().stroke(location.color, lineWidth: 2))
            
            Text(location.name).foregroundColor(.gray)
            
            Text("Coordenadas: \(location.coordinate.latitude), \(location.coordinate.longitude)")
                .font(.subheadline)
                .foregroundColor(.gray)

        }
        .padding()
        .presentationDetents([.fraction(0.4), .large])
    }
}

#Preview {
    MapView()
}
