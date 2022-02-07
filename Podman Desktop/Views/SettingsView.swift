//
//  SettingsView.swift
//  Podman Desktop
//
//  Created by Ashley Cui on 12/9/21.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var allMachines: AllMachines
    var body: some View {
        VStack {
            Group{
                ZStack{
                    Color.white
                    HStack{
                        Text("Settings")
                            .multilineTextAlignment(.leading)
                            .font(.title2)
                        Spacer()
                        Button(action: {
                            viewRouter.currentPage = .land
                                    }){
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.gray)
                                            .frame(width: 20, height: 20)
                                    }
                                    .padding(.trailing)
                                    .opacity(1)
                                    .buttonStyle(PlainButtonStyle())

                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                }

                .frame(height: 50, alignment: .leading)
            }
            Spacer()
            Group{
                Image("podman-large")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                Spacer()
                HStack{
                    Text("Podman Virtual Machine")
                        .font(.title)
                    Spacer()
                    Image("debug")
                }
                Divider()
            Spacer()
            }
            .frame(width: 700)
            Group{
                HStack{
                    Spacer()
                    VStack(alignment: .leading){
                        HStack{
                            Text("Name: ")
                            Text(allMachines.activeMachine!.name)
                        }
                        HStack{
                            Text("VM Type: ")
                            Text(allMachines.activeMachine!.vmtype)
                        
                        }
                        HStack{
                            Text("Created: ")
                            Text(allMachines.activeMachine!.created)
                        }
                    }
                    Spacer()
                    VStack(alignment: .leading){
                        HStack{
                            Text("CPUs: ")
                            Text(String(allMachines.activeMachine!.cpus))
                        }
                        HStack{
                            Text("RAM: ")
                            Text(allMachines.activeMachine!.memory)
                        
                        }
                        HStack{
                            Text("Disk Size: ")
                            Text(allMachines.activeMachine!.disksize)
                        }
                        }
                    Spacer()
                }
            }
            .frame(width: 700)
            Spacer()
            
            Button("Use a different VM for podman machine"){
                viewRouter.currentPage = .machineSelect
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))

            
            HStack{
                Link("Visit the Podman Website", destination: URL(string: "https://podman.io")!)
                    .padding()
                Link("Join the Podman Community", destination: URL(string: "https://podman.io/community")!)
                    .padding()

                Link("Report a Problem", destination: URL(string: "https://github.com/containers/podman-desktop/issues")!)
                    .padding()

            }
        .padding()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let situations: [(name: String, allMachines: AllMachines)] = [
            ("Running", AllMachines.previewWithOneRunningMachine()),
            ("Stopped", AllMachines.previewWithOneStoppedMachine()),
            // Currently crashes
            // ("No machine", AllMachines.previewWithNoMachines()),
        ]
        ForEach(situations, id: \.name) { s in
            SettingsView()
                .environmentObject(s.allMachines)
                .environmentObject(ViewRouter())
                .previewDisplayName(s.name)
        }
    }
}
