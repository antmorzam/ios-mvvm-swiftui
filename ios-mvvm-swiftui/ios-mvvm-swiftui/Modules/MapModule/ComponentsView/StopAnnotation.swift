//
//  StopAnnotation.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 28/2/24.
//

import Foundation
import MapKit

struct StopAnnotationModel {
    var identifier: Int
    var coordinate: CLLocationCoordinate2D
}

class StopAnnotation: NSObject, MKAnnotation {
    var identifier: Int
    var coordinate: CLLocationCoordinate2D
    
    init(stopAnnotationModel: StopAnnotationModel) {
        identifier = stopAnnotationModel.identifier
        coordinate = CLLocationCoordinate2D(latitude: stopAnnotationModel.coordinate.latitude, longitude: stopAnnotationModel.coordinate.longitude)
        super.init()
    }
}
