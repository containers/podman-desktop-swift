//
//  MenuBar.swift
//  Podman Desktop
//
//  Created by Ashley Cui on 12/9/21.
//

import SwiftUI

struct MenuBar: View {
    @State private var machineOn=false
    var body: some View {
        VStack{
        ZStack {
                Color("podman-purple")
                .ignoresSafeArea()
            ZStack{
                Image("podman-1")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                  .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
        }
        .frame(height: 60)
                VStack(spacing: 0){
                    Spacer()
                    Text ("Podman is:")
                        .foregroundColor(.black)
        //            ProgressView()
                    if machineOn {
                                    Text("running")
                            .foregroundColor(.black)
                                }
                                if !machineOn {
                                    Text("not running")
                                        .foregroundColor(.black)
                    
                                }
                                Toggle("", isOn: $machineOn)
                        .toggleStyle(SwitchToggleStyle(tint: Color("toggle-on")))
                    Spacer()
                    Button("Manage Podman"){
                      openPreferences()
                    }
            Spacer()
        }
        }

    }
    func openPreferences(){
        let mainWindow = NSWindow(contentViewController: NSHostingController(rootView: ContentView()))
        mainWindow.styleMask = [.resizable, .titled, .closable, .miniaturizable, .fullSizeContentView]
        mainWindow.titlebarAppearsTransparent = true
        mainWindow.titleVisibility = .hidden
        let controller = NSWindowController(window: mainWindow)
        controller.showWindow(nil)
      }
}
struct PreferencesView: View {
  var body: some View {
    Text("Preferences")
      .frame(width:300, height:200)
  }
}
struct MenuBar_Previews: PreviewProvider {
    static var previews: some View {
        MenuBar()
    }
}
