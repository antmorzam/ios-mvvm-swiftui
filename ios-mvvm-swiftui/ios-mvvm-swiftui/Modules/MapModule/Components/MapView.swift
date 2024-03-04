//
//  MapView.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 27/2/24.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @EnvironmentObject private var locationManager: LocationManager
    @EnvironmentObject private var viewModel: MainViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = viewModel.region
        mapView.showsUserLocation = true

        locationManager.requestLocationUpdate()
        
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.removeOverlays(view.overlays)
        view.removeAnnotations(view.annotations)
        
        if let userLocation = locationManager.userLocation, viewModel.selectedStops.isEmpty {
            let updatedRegion = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            view.setRegion(updatedRegion, animated: true)
        } else {
            view.setRegion(viewModel.region, animated: true)
        }
        
        view.addAnnotations(viewModel.selectedStops)
        let polyline = MKPolyline(coordinates: viewModel.coordinates, count: viewModel.coordinates.count)
        view.addOverlay(polyline)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func handleButtonTap(identifier: Int) async {
        do {
            try await self.viewModel.getStopInfo(identifier: identifier)
        } catch { }
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
            DispatchQueue.main.async {
                Task {
                    await self.parent.handleButtonTap(identifier: annotation.identifier)
                }
            }
        }
    }
}
