//
//  LocationsView.swift
//  SwiftMap
//
//  Created by Jan Schwietzer on 21.11.23.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @StateObject private var vm = LocationsViewModel()
    
    
    
    var body: some View {
        ZStack {
            Map(position: $vm.mapCameraPos, interactionModes: .all) {
                ForEach(vm.locations) { location in
                    Annotation(location.name, coordinate: location.coordinates) {
                        Button {
                            vm.mapLocation = location
                        } label: {
                            VStack(spacing: 0) {
                                Image(systemName: "mappin.square.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 20, height: 20)
                                Image(systemName: "arrowtriangle.down.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 5, height: 5)
                            }
                        }
                    }
                    .annotationTitles(location == vm.mapLocation ? .visible : .hidden)
                        
                }
            }
            MenuOverlayView()
                .environmentObject(vm)
            
            ZStack {
                ForEach(vm.locations) { location in
                    if vm.mapLocation == location {
                        InfoOverlayView()
                            .environmentObject(vm)
                            .padding(.horizontal, 10)
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    }
                }
            }
            
        }
    }
}

#Preview {
    LocationsView()
}
