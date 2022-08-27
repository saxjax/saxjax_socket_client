//
//  SocketProgrammingUI.swift
//  IntelligentSystemsJobTest
//
//  Created by Jakob Skov Søndergård on 22/08/2022.
//

import SwiftUI

struct SocketProgrammingUI: View {
  @ObservedObject var socketMng:SaxjaxSocketManager
  @State var isSending:Bool
  var timer = Timer.publish(every:5, tolerance: 0.5, on: .main, in: .common).autoconnect()

  var body: some View {
    VStack {
      Text(socketMng.message as! String)
        .onReceive(timer) { _ in
          if isSending {
            socketMng.sendPacket()
          }else{
            //                  timer.upstream.connect().cancel()
          }
        }
      //MARK: -connect disconnect to socket
      HStack {

        Button("connect"){
          isSending = false
          socketMng.connect()
        }.disabled(socketMng.isConnected)
        Divider()

        socketMng.isConnected ?
        Button("diconnect"){
          isSending = false
          socketMng.closeConnection()
        }
        : nil
      }
      Divider()
      // MARK: -try to send packet
      Button(isSending ? "stop packets":"send new packet every 5sec"){
        isSending.toggle()
      }.disabled(!socketMng.isConnected)


    }.buttonStyle(BorderlessButtonStyle())
  }
}

struct SocketProgrammingUI_Previews: PreviewProvider {
    static var previews: some View {
      SocketProgrammingUI(socketMng: SaxjaxSocketManager(), isSending: false)
    }
}
