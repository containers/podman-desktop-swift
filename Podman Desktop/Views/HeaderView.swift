//
//  Header.swift
//  Podman Desktop
//
//  Created by Ashley Cui on 12/2/21.
//

import SwiftUI

struct HeaderView: View {
    @Binding var settings: Bool
    var body: some View {
        ZStack {
                   Color("podman-purple")
                       .ignoresSafeArea()
                   
            ZStack{
                Image("podman-1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                MachineControls(settings: $settings)
            }
           }
    }
}

struct MachineControls: View{

    @Binding var settings: Bool
    @EnvironmentObject var machineOn: MachineOn
    var body: some View{
        
        
        HStack{
            Spacer()
            Text ("Podman is:")
                .foregroundColor(.gray)
//            ProgressView()

            Text(machineOn.displayString)
                    .foregroundColor(.white)

            let binding = Binding(
                get: { machineOn.isOn },
                set: {
                    if !machineOn.isOn{
                        do {
                            machineOn.displayString = "starting"
                            let output = try shell(launchPath: "/usr/bin/env", arguments: ["podman","machine", "start"])
                            if output.0 == 0{
                            machineOn.isOn = $0
                                machineOn.displayString = "running"
                            }
                        }
                        catch {
                            print("\(error)") //handle or silence the error here
                        }
                    }
                    else{
                        do {
                            let output = try shell(launchPath: "/usr/bin/env", arguments: ["podman","machine", "stop"])
                            if output.0 == 0{
                            machineOn.isOn = $0
                            machineOn.displayString = "not running"
                            }
                        }
                        catch {
                            print("\(error)") //handle or silence the error here
                        }
                        
                    }
                }
                   )
            Toggle("", isOn: binding)
            
                .toggleStyle(
SwitchToggleStyle(tint: Color("toggle-on")))

                            .padding(.trailing)
            Button(action: {
                self.settings.toggle()
                            print("gear button")
                        }){
                            Image(systemName: "gearshape.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                        }
                        .padding(.trailing)
                        .opacity(1)

        }
        .buttonStyle(PlainButtonStyle())
    }
}
