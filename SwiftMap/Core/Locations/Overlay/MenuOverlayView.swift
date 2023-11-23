//
//  OverlayView.swift
//  SwiftMap
//
//  Created by Jan Schwietzer on 22.11.23.
//

import SwiftUI

struct MenuOverlayView: View {
    
    @EnvironmentObject var vm: LocationsViewModel
    
    var body: some View {
        VStack {
            headerView.padding(.horizontal).padding(.top)
            vm.showList ? listView : nil
            Spacer()
        }
    }
    
    func toggleList() {
        withAnimation(.bouncy) {
            vm.showList.toggle()
        }
    }
}

extension MenuOverlayView {
    private var headerView: some View {
        Button {
            toggleList()
        } label: {
        VStack {
            Text("\(vm.mapLocation.name), \(vm.mapLocation.cityName)")
                .font(.title2)
                .fontWeight(.black)
                .foregroundStyle(.primary)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .animation(.none, value: vm.mapLocation)
                .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showList ? 180 : 0))
                    }
                }
        }
        .background()
        .foregroundStyle(.primary)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(height: 55)
        .shadow(radius: 20)
    }
    
    private var listView: some View {
        List {
            ForEach(vm.locations) { location  in
                Button {
                    vm.showList.toggle()
                    vm.switchLocation(location: location)
                } label: {
                    HStack {
                        if let imageName = location.imageNames.first {
                            Image(imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 45, height: 45)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        VStack(alignment: .leading) {
                            Text(location.name)
                                .font(.headline)
                            Text(location.cityName)
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
        .listStyle(.plain)
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(height: CGFloat(vm.locations.count * 67))
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal)
        .padding(.bottom)
        .shadow(radius: 20)
    }
}

#Preview {
    MenuOverlayView()
        .environmentObject(LocationsViewModel())
}
