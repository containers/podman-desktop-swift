//
//  MachineInitView.swift
//  Podman Desktop
//
//  Created by Ashley Cui on 12/18/22.
//

import SwiftUI

struct MachineSelectView: View {
    @ObservedObject var allMachines = AllMachines()
    @State private var chosenVM = ""
    var body: some View {
        Picker("VM", selection: $chosenVM){
            ForEach(allMachines.lst, id: \.self) { item in
                Text(item.name)
        }
    }
        Text("Selected: \(chosenVM)")
    }
}

struct MachineSelectView_Previews: PreviewProvider {
    static var previews: some View {
        MachineSelectView()
    }
}
