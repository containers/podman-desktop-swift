//
//  Header.swift
//  Podman Desktop
//
//  Created by Ashley Cui on 12/2/21.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        ZStack {
                   Color("podman-purple")
                       .ignoresSafeArea()
                   
            ZStack{
                Image("podman-1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                MachineControls()
            }
        }
    }
}
//
struct MachineControls: View{

    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var allMachines: AllMachines
    @State var starting: Bool = false
    var body: some View{


        HStack{
            Spacer()
            Text("Podman is:")
                .foregroundColor(.gray)
            if starting{
            Text("starting")
                .foregroundColor(.white)
                ProgressView()
            } else{
                Text (allMachines.runningString)
                .foregroundColor(.white)
            }
            Button {
                allMachines.reloadAll()
                if !allMachines.running{
                    Task{
                        do {starting = true
                            var exitcode = try await allMachines.startActive()
                            allMachines.reloadAll()
                            starting = false
                        }
                    catch {print("error")} // TODO: plumb custom errors
                    }
                    
                } else {
                    Task{
                    do {try await allMachines.stopActive()
                        allMachines.reloadAll()
                    }
                    catch {print("error")} // TODO: plumb custom errors
                    }
                }
            } label: {
                Image(systemName: "power.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(allMachines.running ? .green : .white, allMachines.running ? .white : .purple )
                    .frame(width: 25, height: 25)
            }
            .padding(.trailing)
            
            Button(action: {
                if viewRouter.currentPage == .land{
                    viewRouter.currentPage = .settings
                }else{
                    viewRouter.currentPage = .land
                }
                        }){
                            Image(systemName: "gearshape")
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

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        let situations: [(name: String, allMachines: AllMachines)] = [
            ("Running", AllMachines.previewWithOneRunningMachine()),
            ("Stopped", AllMachines.previewWithOneStoppedMachine()),
            ("No machine", AllMachines.previewWithNoMachines()),
        ]
        ForEach(situations, id: \.name) { s in
            HeaderView()
                .environmentObject(s.allMachines)
                .environmentObject(ViewRouter())
                .previewDisplayName(s.name)
        }
    }
}
