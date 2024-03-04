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

enum MainAlert {
    case error, info
}

struct MainView: View {
    @StateObject private var viewModel = MainViewModel(tripServiceDelegate: TripService())
    private let locationManager = LocationManager()
    
    @State var polyline: String = ""
    @State var stopIdentifier: Int?
    @State var selectedStop: StopInfo?
    @State var showAlert = false
    @State var mainAlert: MainAlert = .error
    @State var addIssue = false
    
    var body: some View {
        ZStack(alignment: .center) {
            MapView()
                .environmentObject(locationManager)
                .environmentObject(viewModel)
                .edgesIgnoringSafeArea(.all)
                .onReceive(viewModel.$selectedStop) { stopInfo in
                    if let _ = stopInfo {
                        showAlert = true
                        mainAlert = .info
                    }
                }
                
            VStack {
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        if viewModel.isLoading {
                            CardView(isLoading: true, isSelected: .constant(false))
                                .frame(width: UIScreen.main.bounds.width)
                        } else {
                            ForEach(viewModel.tripList, id: \.self) { trip in
                                CardView(status: trip.status,
                                         origin: trip.origin.address,
                                         destination: trip.destination.address,
                                         isLoading: viewModel.isLoading,
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
                                .frame(width: UIScreen.main.bounds.width)
                            }
                        }
                    }
                }
            }
            if viewModel.isLoadingStopInfo {
                VStack{
                    LoadingView()
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
                mainAlert = .error
            }
        }
        .alert(isPresented: $showAlert) {
            switch mainAlert {
            case .error:
                return Alert(title: Text("Error"),
                             message: Text(viewModel.error?.description ?? "Unknown error"),
                      dismissButton: .default(Text("OK")))
            case .info:
                return Alert(title: Text("Stop Information"),
                             message: Text("\(viewModel.selectedStop?.address ?? "").\n User: \(viewModel.selectedStop?.userName ?? "")"),
                             dismissButton: .default(Text("OK")))
            }
        }
        .sheet(isPresented: $addIssue) {
            FormView(isPresented: $addIssue)
                .background(Color.backgroundColor)
        }
        .overlay(
            AddIssueView(addIssue: $addIssue),
            alignment: .topTrailing
        )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
