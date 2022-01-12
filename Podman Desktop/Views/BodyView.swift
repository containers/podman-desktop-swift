//
//  Body.swift
//  Podman Desktop
//
//  Created by Ashley Cui on 11/10/21.
//

import SwiftUI

struct BodyView: View {
    @EnvironmentObject var machineOn: MachineOn
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
            Toggle("Run Podman", isOn: $machineOn.isOn)
                .toggleStyle(SwitchToggleStyle(tint: Color("toggle-on")))
            Spacer()
        }
    }
}

struct BodyView_Previews: PreviewProvider {
    static var previews: some View {
        BodyView()
    }
}
