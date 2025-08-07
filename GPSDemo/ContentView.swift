//
//  ContentView.swift
//  GPSDemo
//
//  Created by Nathan Cho on 8/6/25.
//

import SwiftUI
import CoreLocation
import MapKit

struct ContentView: View {
    @StateObject var locationManager: LocationManager

    init(locationManager: LocationManager = LocationManager()) {
        _locationManager = StateObject(wrappedValue: locationManager)
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }

    var body: some View {
        VStack(spacing: 20) {
            if let location = locationManager.location {
                // ✅ New Map API (iOS 17+)
                Map(position: .constant(
                    MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: location.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        )
                    )
                )) {
                    // Optional future annotations
                }
                .frame(height: 300)

                Text("Latitude: \(location.coordinate.latitude) \(locationManager.isSimulated ? "(simulated)" : "")")
                Text("Longitude: \(location.coordinate.longitude) \(locationManager.isSimulated ? "(simulated)" : "")")

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
                ProgressView("Getting location...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }

            // 🔄 Refresh button
            Button("Refresh Location") {
                locationManager.refreshLocation()
            }
            .disabled(locationManager.isUpdatingLocation)
            .padding()
            .background(locationManager.isUpdatingLocation ? Color.gray : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            // 🧪 Debug toggle
            Toggle("Debug Mode", isOn: $locationManager.debugMode)
                .padding(.horizontal)

            if locationManager.debugMode {
                Text("Random GPS testing enabled")
                    .font(.caption)
                    .foregroundColor(.orange)
            }
        }
        .padding()
    }
}

//#Preview {
//    let mockManager = LocationManager()
//    mockManager.location = CLLocation(latitude: 37.7749, longitude: -122.4194) // San Francisco
//    mockManager.lastUpdateTime = Date()
//    mockManager.debugMode = true
//    mockManager.isSimulated = true
//    mockManager.isUpdatingLocation = false
//
//    return ContentView(locationManager: mockManager)
//}


#Preview {
    ContentView()
}
