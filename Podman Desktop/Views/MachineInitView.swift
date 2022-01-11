//
//  MachineInitView.swift
//  Podman Desktop
//
//  Created by Ashley Cui on 12/18/22.
//

import SwiftUI

struct MachineInitView: View {
    @State private var name: String = ""
    @State private var vmimage: String = ""
    @State private var cpus: String = ""
    @State private var memory: String = ""
    @State private var disksize: String = ""
    @State private var ignition: String = ""

    var body: some View {
        VStack{
            TextField(
                "VM Name",
                text: $name
            )
//            .onSubmit {
//                validate(name: uname)
//            }
            TextField(
                "VM image",
                text: $vmimage
            )
            TextField(
                "CPUs",
                text: $cpus
            )
            TextField(
                "RAM",
                text: $memory
            )
            TextField(
                "Disk size",
                text: $disksize
            )
            TextField(
                "Ignition File",
                text: $ignition
            )
            Button("Submit") {
                // need to validate data, make sure no fields are emptyhere
                
                do {
                    try shell(launchPath: "/usr/bin/env", arguments: ["podman","machine", "init", "--cpus", cpus, "--memory", memory, "--disk-size", disksize, "--ignition-path", ignition, "--image-path", vmimage, name])
                    
                }
                catch {
                    print("asdsad")
                    print("\(error)") // need to write custom errors
                }
            }
        }
}
}


struct MachineInitView_Previews: PreviewProvider {
    static var previews: some View {
        MachineInitView()
    }
}
