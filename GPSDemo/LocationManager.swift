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

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            location = firstLocation
            lastUpdateTime = Date()
            locationManager.stopUpdatingLocation() // Stop to save battery
        }
    }

    func refreshLocation() {
        location = nil
        lastUpdateTime = nil
        locationManager.startUpdatingLocation()
    }
}
