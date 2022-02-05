//
//  Body.swift
//  Podman Desktop
//
//  Created by Ashley Cui on 11/10/21.
//

import SwiftUI

struct BodyView: View {
    @EnvironmentObject var allMachines: AllMachines
    var body: some View {
        VStack{
        Spacer()
        Image("selkie-artwork")
            .resizable()
            .scaledToFit()
            .frame(width: 150)
            Text("Welcome to Podman Desktop")
                .font(.title)
                .padding()
            Text("To start working with containers on Podman, \nyou'll need to run the Podman service.")
                .multilineTextAlignment(.center)
            Button {
                allMachines.reloadAll()
                if !allMachines.running{
                    Task{
                        do {
                            try await allMachines.startActive()
                            allMachines.reloadAll()

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
                    .frame(width: 50, height: 50)
            }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            .buttonStyle(PlainButtonStyle())
            Spacer()
        }
    }
}

struct BodyView_Previews: PreviewProvider {
    static var previews: some View {
        let situations: [(name: String, allMachines: AllMachines)] = [
            ("Running", AllMachines.previewWithOneRunningMachine()),
            ("Stopped", AllMachines.previewWithOneStoppedMachine()),
            ("No machine", AllMachines.previewWithNoMachines()),
        ]
        ForEach(situations, id: \.name) { s in
            BodyView()
                .environmentObject(s.allMachines)
                .previewDisplayName(s.name)
        }
    }
}
