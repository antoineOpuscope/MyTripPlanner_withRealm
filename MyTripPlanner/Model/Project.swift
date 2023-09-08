//
//  Project.swift
//  MyTripPlanner
//
//  Created by Antoine Omnès on 08/08/2023.
//

import Foundation
import Combine
import CoreLocation
import RealmSwift

class Project: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var name: String
    @Persisted var projectDescription: String// description is not allowed by Realm
    @Persisted var creationDate: Date
    
    @Persisted var locations: RealmSwift.List<Location>
    
    private var subscribers: Set<AnyCancellable> = []

    override class public func propertiesMapping() -> [String: String] {
        ["projectDescription": "description"]
    }
    
    func computeCenter() -> CLLocationCoordinate2D? {
        let coordinates = locations.map({ $0.coordinate})
        guard !coordinates.isEmpty else {
            return nil
        }
        
        var totalLatitude: Double = 0
        var totalLongitude: Double = 0
        
        for coordinate in coordinates {
            totalLatitude += coordinate.latitude
            totalLongitude += coordinate.longitude
        }
        
        let averageLatitude = totalLatitude / Double(coordinates.count)
        let averageLongitude = totalLongitude / Double(coordinates.count)
        
        return CLLocationCoordinate2D(latitude: averageLatitude, longitude: averageLongitude)
    }
    
    convenience init(name: String, description: String, locations: [Location] = []) {
        self.init()
        
        self.name = name
        self.projectDescription = description
        let locationsRealmList = RealmSwift.List<Location>()
        locationsRealmList.append(objectsIn: locations)
        self.locations = locationsRealmList
        
    }
}
