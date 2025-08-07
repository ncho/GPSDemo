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
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }

    var body: some View {
        VStack(spacing: 20) {
            if let location = locationManager.location {
                Text("Latitude: \(location.coordinate.latitude)")
                Text("Longitude: \(location.coordinate.longitude)")
                
                if let updateTime = locationManager.lastUpdateTime {
                    Text("Last updated: \(dateFormatter.string(from: updateTime))")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.top)
                }

                Text("✅ Location updates stopped to save battery")
                    .font(.caption)
                    .foregroundColor(.green)
                    .padding(.top, 10)
            } else {
                Text("Getting location...")
            }

            // ✅ NEW: Refresh Location Button
            Button("Refresh Location") {
                locationManager.refreshLocation()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
