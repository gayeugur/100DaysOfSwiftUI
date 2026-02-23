//
//  ContentView-ViewModel.swift
//  Project14
//
//  Created by gayeugur on 24.02.2026.
//
import Foundation
import _MapKit_SwiftUI
import MapKit
import CoreLocation
import LocalAuthentication

extension ContentView {
    
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        var isUnlocked = false
        var mapType: Int = 0
        
        var selectedMapStyle: MapStyle {
            return switch(mapType) {
            case 0: .standard
            case 1: .hybrid
            default: .standard
            }
        }
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(),
                                       name: "New Location",
                                       description: "",
                                       latitude: point.latitude,
                                       longitude: point.longitude)
            
            locations.append(newLocation)
            save()
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options:[.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data...")
            }
        }
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        self.isUnlocked = true
                    } else {
                        if let authenticationError {
                            print("Authentication failed with error: \(authenticationError.localizedDescription)")
                        }
                    }
                }
            } else {
                if let error {
                    print("Biometric authentication is not available: \(error.localizedDescription)")
                }
            }
        }
    }
}
