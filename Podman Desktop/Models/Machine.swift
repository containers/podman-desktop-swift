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
            print("\(error)") // need to write custom errors
        }
        
        self.lst=jsons
    }
    func getRunning() -> (isRunning: Bool, machineInfo: Machine?){
        let getRunning = AllMachines()
        for mach in getRunning.lst{
            if mach.running{
                return(true, mach)
            }
        }
        return (false, nil)
    }
        
    func getCLIDefault() -> Machine?{
        let getRunning = AllMachines()
        for mach in getRunning.lst{
            if mach.dflt{
                return(mach)
            }
        }
        return(nil)
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
            let jsonData = output.1.data(using: .utf8)!
            jsons = try! JSONDecoder().decode([Machine].self, from: jsonData)


            
        }
        catch {
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
}

class NewMachine: ObservableObject {
    @Published var name: String
    @Published var ignitionPath: String
    @Published var imagePath: String
    @Published var cpus: Int
    @Published var memory: Int
    @Published var disksize: Int
    
    var jsons = [Machine]()
    
    init(){
        self.name = "New Machine"
        self.ignitionPath=""
        self.imagePath="next"
        self.cpus=1
        self.memory=2040
        self.disksize=10
    }
    func validate(){
        
    }
    func create() throws {
        do {
            try shell(launchPath: "/usr/bin/env", arguments: ["podman","machine", "init", "--cpus", String(cpus), "--memory", String(memory), "--disk-size", String(disksize), "--ignition-path", ignitionPath, "--image-path", imagePath, name])
            
        }
        catch {
            print("\(error)") // need to write custom errors
        }
    }
}

