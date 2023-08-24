//
//  MyTripPlannerApp.swift
//  MyTripPlanner
//
//  Created by Antoine Omnès on 07/08/2023.
//

import SwiftUI

@main
struct MyTripPlannerApp: App {
    
    // https://www.avanderlee.com/swiftui/stateobject-observedobject-differences/
    @StateObject var stateController = StateController()
    
    @StateObject var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(stateController)
                .environmentObject(locationManager)
        }
    }
}
