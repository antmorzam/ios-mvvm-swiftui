//
//  MapView.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 27/2/24.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {

    @Binding var stopIdentifier: Int?

    let region: MKCoordinateRegion
    let lineCoordinates: [CLLocationCoordinate2D]
    let annotations: [StopAnnotation]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = region

        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.removeOverlays(view.overlays)
        view.removeAnnotations(view.annotations)
        
        view.region = region
        view.addAnnotations(annotations)
        let polyline = MKPolyline(coordinates: lineCoordinates, count: lineCoordinates.count)
        view.addOverlay(polyline)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func handleButtonTap(identifier: Int) {
        stopIdentifier = identifier
    }
}

class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView
    
    init(_ parent: MapView) {
        self.parent = parent
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = UIColor.systemBlue
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? StopAnnotation {
            parent.handleButtonTap(identifier: annotation.identifier)
        }
    }
}
