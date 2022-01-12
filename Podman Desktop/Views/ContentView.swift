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
        VStack{
            HeaderView(settings: $settings)
                .frame(height: 70)
                .environmentObject(machineOn)

            
//            if self.settings{
//                SettingsView()
//                    .frame(height: 300)
//            }else{
//                BodyView()
//            }
//            SettingsView()
//                .frame(height: 300)
//            MachineInitView()
            BodyView()
            Spacer()
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
        self.isOn = false
        self.displayString="not running"
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
