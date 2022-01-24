//
//  ModelData.swift
//  Podman Desktop
//
//  Created by Ashley Cui on 11/24/21.
//

import Foundation


func shell(launchPath: String, arguments: [String]) throws ->  (Int32, String){
    var str=""
    let process = Process()
    let pipe = Pipe()
    process.executableURL = URL(fileURLWithPath: launchPath) //<--updated
    process.arguments = arguments
    process.standardOutput = pipe
    process.standardError = pipe
    var environment =  ProcessInfo.processInfo.environment
        environment["PATH"] = (environment["PATH"] ?? "")+":/opt/homebrew/bin/:/usr/local/bin/"
        process.environment = environment
    do {
        try process.run()
    }
    catch{
        throw error }

    let outHandle = pipe.fileHandleForReading
    outHandle.readabilityHandler = { pipe in
        if let line = String(data: pipe.availableData, encoding: String.Encoding.utf8) {
            // Update your view with the new text here
            str+=line
        }
    }


    process.waitUntilExit()
    let status = process.terminationStatus
//    // remove the trailing new-line char
    return (status, str)
}
