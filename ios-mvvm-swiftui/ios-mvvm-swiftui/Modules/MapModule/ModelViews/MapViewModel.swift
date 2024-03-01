//
//  MapViewModel.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 27/2/24.
//

import Foundation
import MapKit
import Polyline

class MapViewModel: ObservableObject {
    private let tripServiceDelegate: TripServiceDelegate
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.38074, longitude: 2.18594),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @Published var tripList: [Trip] = []
    @Published var error: UserError?
    @Published var selectedTrip: Trip?
    @Published var selectedStops: [StopAnnotation] = []
    @Published var coordinates: [CLLocationCoordinate2D] = []
    @Published var selectedStop: StopInfo?
    
    init(tripServiceDelegate: TripServiceDelegate) {
        self.tripServiceDelegate = tripServiceDelegate
    }

    // MARK: - Calls to Services
    
    func loadData() async throws {
        do {
            let result = try await tripServiceDelegate.fetchTrip()
            await self.setTripList(result)
        } catch {
            await self.showError(.failedFecthingData)
        }
    }
    
    func getStopInfo() async throws {
        do {
            let result = try await tripServiceDelegate.fetchStop()
            await self.setStop(result)
        } catch {
            await self.showError(.failedFecthingData)
        }
    }
    
    @MainActor
    func setTripList(_ trips: [Trip]) {
        tripList = trips
    }
    
    @MainActor
    func showError(_ error: UserError) {
        self.error = error
    }
    
    @MainActor
    func setStop(_ stopInfo: StopInfo) {
        selectedStop = stopInfo
    }
    
    func setSelectedTrip(_ trip: Trip) {
        selectedTrip = trip
        setStops(trip: trip)
        tripList = tripList.map { existingTrip in
            var mutableTrip = existingTrip
            mutableTrip.isSelected = existingTrip == trip
            return mutableTrip
        }
    }
    
    // MARK: - Private functions
    
    private func setStops(trip: Trip) {
        var stopsToShow: [StopAnnotation] = [createStopAnnotation(id: 0, coordinates: trip.origin.point.coordinate),
                                             createStopAnnotation(id: 0, coordinates: trip.destination.point.coordinate)]
        trip.stops.forEach { stop in
            if let coordinates = stop.point?.coordinate {
                stopsToShow.append(createStopAnnotation(id: stop.id ?? 0, coordinates: coordinates))
            }
        }
        selectedStops = stopsToShow
        if let coordinates = Polyline(encodedPolyline: trip.route).coordinates {
            self.coordinates = coordinates
        }
        regionThatFitsCoordinates()
    }
    
    private func createStopAnnotation(id: Int, coordinates: CLLocationCoordinate2D) -> StopAnnotation {
        StopAnnotation(stopAnnotationModel: StopAnnotationModel(identifier: id, coordinate: coordinates))
    }
    
    private func regionThatFitsCoordinates() {
        let coordinates = coordinates.map { $0 }
        guard let minLat = coordinates.min(by: { $0.latitude < $1.latitude })?.latitude,
              let maxLat = coordinates.max(by: { $0.latitude < $1.latitude })?.latitude,
              let minLon = coordinates.min(by: { $0.longitude < $1.longitude })?.longitude,
              let maxLon = coordinates.max(by: { $0.longitude < $1.longitude })?.longitude else {
            return
        }
        
        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2, longitude: (minLon + maxLon) / 2)
        let span = coordinates.count == 1 ? MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) :
                                            MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.1, longitudeDelta: (maxLon - minLon) * 1.1)
        
        region = MKCoordinateRegion(center: center, span: span)
    }
}
