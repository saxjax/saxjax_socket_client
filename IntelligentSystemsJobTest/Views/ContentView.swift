//
//  ContentView.swift
//  IntelligentSystemsJobTest
//
//  Created by Jakob Skov Søndergård on 19/08/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @StateObject var socketMng = SaxjaxSocketManager()
  @State var isSending = false

  var body: some View {
    List {
//MARK: - Socket programming UI
      Section("Socket chat") {
        SocketProgrammingUI(socketMng: socketMng, isSending: isSending)
      }
    }
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}


