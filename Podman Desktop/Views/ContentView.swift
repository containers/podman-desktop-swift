//
//  ContentView.swift
//  Podman Desktop
//
//  Created by Ashley Cui on 11/9/21.
//

import SwiftUI



struct ContentView: View {
    var allMachines = AllMachines()
    @StateObject var viewRouter = ViewRouter()
    var body: some View {
        VStack(spacing: 0){
            HeaderView()
                .frame(height: 70)
                .environmentObject(allMachines)
                .environmentObject(viewRouter)
                .onAppear {
                    allMachines.reloadAll()
                }

            switch viewRouter.currentPage {
            case .land:
                BodyView()
                    .environmentObject(viewRouter)
                    .environmentObject(allMachines)
            case .settings:
                SettingsView()
                    .environmentObject(viewRouter)
                    .environmentObject(allMachines)
            case .machineSelect:
                MachineSelectView()
                    .environmentObject(viewRouter)
                    .environmentObject(allMachines)
            case .machineInit:
                MachineInitView()
                    .environmentObject(viewRouter)
                    .environmentObject(allMachines)
            }
            Spacer()
        }
        .ignoresSafeArea()
        .frame(minWidth: 800, maxWidth: .infinity, minHeight: 500,  maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
