//
//  ModelData.swift
//  Podman Desktop
//
//  Created by Ashley Cui on 11/24/21.
//

import Foundation

var machines: [Machine] = load("landmarkData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}


func shell(launchPath: String, arguments: [String]) throws ->  (Int32, String){
    var str=""
    let process = Process()
    let pipe = Pipe()
    process.executableURL = URL(fileURLWithPath: launchPath) //<--updated
    process.arguments = arguments
    process.standardOutput = pipe
    process.standardError = pipe
    var environment =  ProcessInfo.processInfo.environment
        environment["PATH"] = (environment["PATH"] ?? "")+":/opt/homebrew/bin/podman:/usr/local/bin/podman"
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
