//
//  MainView.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 29/2/24.
//

import Foundation
import SwiftUI
import MapKit
import Polyline

struct MainView: View {
    @StateObject private var viewModel = MapViewModel(tripServiceDelegate: TripService())
    @State var showAlert = false
    @State var polyline: String = ""
    @State var stopIdentifier: Int?
    @State var selectedStop: StopInfo?
    @State var showStopInfo = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            MapView(stopIdentifier: $stopIdentifier, region: viewModel.region, lineCoordinates: viewModel.coordinates, annotations: viewModel.selectedStops)
            .edgesIgnoringSafeArea(.all)
            .onReceive(viewModel.$selectedStop) { stopInfo in
                if let _ = stopInfo {
                    showStopInfo = true
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.tripList, id: \.self) { trip in
                        CardView(status: trip.status,
                                 origin: trip.origin.address,
                                 destination: trip.destination.address,
                                 isSelected: Binding(
                                    get: { viewModel.selectedTrip == trip },
                                    set: { selected in
                                        viewModel.selectedTrip = selected ? trip : nil
                                    }
                                 )
                        )
                        .onTapGesture {
                            viewModel.setSelectedTrip(trip)
                        }
                        .frame(width: UIScreen.main.bounds.width - 20)
                    }
                }
            }
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.loadData()
                } catch {}
            }
        }
        .onReceive(viewModel.$error) { userError in
            if let _ = userError {
                showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"),
                  message: Text(viewModel.error?.description ?? "Unknown error"),
                  dismissButton: .default(Text("OK")))
        }
        .onChange(of: stopIdentifier) { newSelectedStop in
            Task {
                do {
                    try await viewModel.getStopInfo()
                }
            }
        }
        .alert(isPresented: $showStopInfo) {
            Alert(title: Text("Stop Information"),
                  message: Text("\(viewModel.selectedStop?.address ?? "").\n User: \(viewModel.selectedStop?.userName ?? "")"),
                  dismissButton: .default(Text("OK")))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
