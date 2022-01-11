//
//  SelectMachineView.swift
//  Podman Desktop
//
//  Created by Ashley Cui on 12/12/22.
//

import SwiftUI



struct SelectMachineView: View {
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

struct SelectMachineView_Previews: PreviewProvider {
    static var previews: some View {
        SelectMachineView()
    }
}
