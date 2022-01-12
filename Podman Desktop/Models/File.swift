//
//  File.swift
//  Podman Desktop
//
//  Created by Ashley Cui on 11/17/21.
//

import Foundation
import SwiftUI

struct Machine: Hashable, Codable {
    var name: String
    var dflt: Bool
    var created: String
    var running: Bool
    var lastup: String
    var stream: String
    var vmtype: String
    var cpus: Int
    var memory: String
    var disksize: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "Name"
        case dflt = "Default"
        case created = "Created"
        case running = "Running"
        case lastup = "LastUp"
        case stream = "Stream"
        case vmtype = "VMType"
        case cpus = "CPUs"
        case memory = "Memory"
        case disksize = "DiskSize"

    }
}

struct MachineList: Decodable {
  var machines: [Machine]
}

class AllMachines: ObservableObject{
    @Published var lst: [Machine]
    var jsons = [Machine]()
    
    init(){
        do {
            let output = try shell(launchPath: "/usr/bin/env", arguments: ["podman","machine", "list", "--format", "json"])
            print(output.1)
            let jsonData = output.1.data(using: .utf8)!
            jsons = try! JSONDecoder().decode([Machine].self, from: jsonData)

            
        }
        catch {
            print("asdsad")
            print("\(error)") // need to write custom errors
        }
        
        self.lst=jsons
        print(lst)
        let t = type(of: lst[0].name)
            print("of type '\(t)'")
    }
}

class DefaultMachine: ObservableObject {
    @Published var name: String
    @Published var `default`: Bool
    @Published var created: String
    @Published var running: Bool
    @Published var lastup: String
    @Published var stream: String
    @Published var vmtype: String
    @Published var cpus: Int
    @Published var memory: String
    @Published var disksize: String
    
    var jsons = [Machine]()
    
    init(){
        do {
            let output = try shell(launchPath: "/usr/bin/env", arguments: ["podman","machine", "list", "--format", "json"])
            print(output.1)
            let jsonData = output.1.data(using: .utf8)!
            jsons = try! JSONDecoder().decode([Machine].self, from: jsonData)


            
        }
        catch {
            print("asdsad")
            print("\(error)") //handle or silence the error here
        }
        self.name = jsons[0].name
        self.default = jsons[0].dflt
        self.created=jsons[0].created
        self.running=jsons[0].running
        self.lastup=jsons[0].lastup
        self.stream=jsons[0].stream
        self.vmtype=jsons[0].vmtype
        self.cpus=jsons[0].cpus
        self.memory=jsons[0].memory
        self.disksize=jsons[0].disksize
    }

