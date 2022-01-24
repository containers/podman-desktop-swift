//
//  SettingsView.swift
//  Podman Desktop
//
//  Created by Ashley Cui on 12/9/21.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var currMachine = DefaultMachine()
    @Binding var settings: Bool
    
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
                            self.settings.toggle()
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
                .padding(EdgeInsets(top: 54, leading: 0, bottom: 0, trailing: 0))
                .frame(height: 100, alignment: .leading)
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
                HStack{
                    Spacer()
                    VStack(alignment: .leading){
                        HStack{
                            Text("Name: ")
                            Text(currMachine.name)
                        }
                        HStack{
                            Text("VM Type: ")
                            Text(currMachine.vmtype)
                        
                        }
                        HStack{
                            Text("Created: ")
                            Text(currMachine.created)
                        }
                    }
                    Spacer()
                    VStack(alignment: .leading){
                        HStack{
                            Text("CPUs: ")
                            Text(String(currMachine.cpus))
                        }
                        HStack{
                            Text("RAM: ")
                            Text(currMachine.memory)
                        
                        }
                        HStack{
                            Text("Disk Size: ")
                            Text(currMachine.disksize)
                        }
                        }
                    Spacer()
                }
            }
            .frame(width: 700)
            Spacer()
            Button("Use a different VM for podman machine"){
                print("init")
            }

            HStack{
                Button("Visit the Podman Website"){
                    print("init")
                }
                Button("Join the Podman Community"){
                    print("init")
                }
                Button("Report a Problem"){
                    print("init")
                }
            }
        .padding()
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    @Binding var settings: Bool
//    static var previews: some View {
//        SettingsView(settings: settings)
//    }
//}
