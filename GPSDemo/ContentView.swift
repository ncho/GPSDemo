//
//  ContentView.swift
//  GPSDemo
//
//  Created by Nathan Cho on 8/6/25.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                Text("LATITUDE: \(location.coordinate.latitude)")
                Text("LONGITUDE: \(location.coordinate.longitude)")
            } else {
                Text("Getting location...")
            }
        }
        .padding()
    }
}
#Preview {
    ContentView()
}
