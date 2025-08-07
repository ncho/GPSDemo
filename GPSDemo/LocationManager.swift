//
//  LocationManager.swift
//  GPSDemo
//
//  Created by Nathan Cho on 8/6/25.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var location: CLLocation?
    @Published var lastUpdateTime: Date?
    @Published var isUpdatingLocation = false
    @Published var debugMode = false  // ✅ Toggle for debug behavior
    @Published var isSimulated = false // ✅ Track if location is fake

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        isUpdatingLocation = true
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !debugMode else { return }  // ✅ Ignore real updates if simulating

        if let firstLocation = locations.first {
            location = firstLocation
            lastUpdateTime = Date()
            isUpdatingLocation = false
            isSimulated = false              // ✅ Real location
            locationManager.stopUpdatingLocation()
        }
    }

    func refreshLocation() {
        location = nil
        lastUpdateTime = nil
        isUpdatingLocation = true

        if debugMode {
            // ✅ Simulate location after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                let fakeLatitude = 37.0 + Double.random(in: -0.5...0.5)
                let fakeLongitude = -122.0 + Double.random(in: -0.5...0.5)
                let fakeLocation = CLLocation(latitude: fakeLatitude, longitude: fakeLongitude)

                self.location = fakeLocation
                self.lastUpdateTime = Date()
                self.isUpdatingLocation = false
                self.isSimulated = true       // ✅ Mark as fake
            }
        } else {
            isSimulated = false              // ✅ Real mode
            locationManager.startUpdatingLocation()
        }
    }
}
