//
//  LocationModel.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 27/2/24.
//

import Foundation
import CoreLocation

struct Location: Codable {
    let address: String
    let point: Point
}

struct Point: Codable, Identifiable {
    var id: UUID { UUID() }
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    enum CodingKeys: String, CodingKey {
        case latitude = "_latitude"
        case longitude = "_longitude"
    }
}
