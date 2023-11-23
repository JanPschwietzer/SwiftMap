//
//  LocationsViewModel.swift
//  SwiftMap
//
//  Created by Jan Schwietzer on 21.11.23.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    @Published var showList = false
    
    @Published var locations: [Location]
    @Published var mapLocation: Location {
        didSet {
            changeMapCameraPos(location: mapLocation)
        }
    }
    @Published var mapCameraPos = MapCameraPosition.userLocation(fallback: MapCameraPosition.automatic)
    private let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init() {
        let locations = LocationsDataService.locations
        
        self.locations = locations
        mapLocation = locations.first!
        mapCameraPos = MapCameraPosition.region(MKCoordinateRegion(center: locations.first!.coordinates, span: mapSpan))
    }
    
    func goToNextLocation() {
        let i = locations.firstIndex(of: mapLocation) ?? 0
        
        if locations.count == 0 {
            return
        }
        
        if i < (locations.count - 1) {
            mapLocation = locations[i+1]
        } else if i == locations.count - 1 {
            mapLocation = locations.first!
        }
    }
    
    func changeMapCameraPos(location: Location) {
        withAnimation(.easeInOut) {
            mapCameraPos = MapCameraPosition.region(MKCoordinateRegion(center: location.coordinates, span: mapSpan))
        }
    }
    
    func switchLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
        }
    }
}
