//
//  ContentView.swift
//  Podman Desktop
//
//  Created by Ashley Cui on 11/9/21.
//

import SwiftUI



struct ContentView: View {
    var machineOn = MachineOn()
    @State private var settings = false
    var body: some View {
        VStack(spacing: 0){
            HeaderView(settings: $settings)
                .frame(height: 70)
                .environmentObject(machineOn)

//            AnotherView()
            if self.settings{
                SettingsView(settings: $settings)
                    .frame(height: 300)
                Spacer()
            }else{
                BodyView()
            }
//            SettingsView(settings: $settings)
//                .frame(height: 300)
//            MachineInitView()
            Spacer()
//            BodyView()
//            Spacer()
        }
        .ignoresSafeArea()

//
//        .menuStyle(BorderlessButtonMenuStyle())
        .frame(minWidth: 800, maxWidth: .infinity, minHeight: 500,  maxHeight: .infinity)
        .environmentObject(machineOn)
    }
}
    
class MachineOn: ObservableObject {
    @Published var isOn: Bool
    @Published var displayString: String
    init(){
        let machs = AllMachines()
        let isRunning = machs.getRunning().isRunning
        if isRunning{
            self.isOn = true
            self.displayString="running"
        } else {
            self.isOn = false
            self.displayString="not running"
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
