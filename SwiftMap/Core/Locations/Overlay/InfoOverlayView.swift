//
//  InfoOverlayView.swift
//  SwiftMap
//
//  Created by Jan Schwietzer on 23.11.23.
//

import SwiftUI

struct InfoOverlayView: View {
    @EnvironmentObject var vm: LocationsViewModel
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 16) {
                    imageSection
                    titleSection
                }
                
                VStack(spacing: 8) {
                    btnLearnMore
                    btnNext
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.ultraThinMaterial)
                    .offset(y: 50)
            )
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .shadow(radius: 10)
        }
    }
}

extension InfoOverlayView {
    
    private var imageSection: some View {
        ZStack {
            if let imageName = vm.mapLocation.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
            }
        }
        .padding(2)
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading) {
            Text(vm.mapLocation.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(vm.mapLocation.cityName)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var btnLearnMore: some View {
        Button {
            openURL(URL(string: vm.mapLocation.link)!)
        } label: {
            Text("Learn more")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var btnNext: some View {
        Button {
            vm.goToNextLocation()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
}

#Preview {
    InfoOverlayView()
        .environmentObject(LocationsViewModel())
}
