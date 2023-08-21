//
//  ProjectMapView.swift
//  MyTripPlanner
//
//  Created by Antoine Omnès on 16/08/2023.
//

import SwiftUI
import CoreLocation

struct ProjectMapView: View {
    
    @ObservedObject var project: Project
    @EnvironmentObject private var stateController: StateController
    
    @State private var isAddingLocation: Bool = false
        
    var body: some View {
        NavigationStack {
            ZStack {
                MapView(project: project, isContextMenuAllowed: true, isAddingLocation: $isAddingLocation)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                isAddingLocation.toggle()
                            } label: {
                                Image(systemName: "plus")
                            }.disabled(isAddingLocation)
                        }
                    }
                if isAddingLocation {
                    VStack {
                        Text("Tap on map to drop a new location")
                            .font(.subheadline.bold())
                            .foregroundStyle(.white)
                            .padding()
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Spacer()
                    }.padding(.top)
                }
            }.navigationTitle("\(project.name)")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProjectMapView(project: TestData.project)
}
