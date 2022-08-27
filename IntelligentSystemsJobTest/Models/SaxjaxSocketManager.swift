//
//  SaxjaxSocketManager.swift
//  IntelligentSystemsJobTest
//
//  Created by Jakob Skov Søndergård on 20/08/2022.
//

import Foundation
import SocketIO

class SaxjaxSocketManager:ObservableObject {
//  @Published var appData = [String]()
  var packetNr = 0
  @Published var message:SocketData
  @Published var isConnected:Bool

  let manager = SocketManager(socketURL: URL(string: "http://Jakobs-MacBook-Pro.local:5001")!, config: [.log(true),.compress])
  var socket: SocketIOClient!

  init() {
    socket =  manager.defaultSocket
    message = ""
    isConnected = false
  }

  var getSocket:SocketIOClient {socket}

  func connect(){
    socket.on(clientEvent: .connect) { data, acknowledgement in
      print("socket connected")
      self.isConnected = true
      self.sendMessage()
      self.socket.emit("message", self.message)
    }

    socket.on(clientEvent: .disconnect){_,_ in
      self.isConnected = false
      self.socket?.disconnect()
      print("returned disconnected from server")
    }

//set isConnected as if it succeeded in connecting, if the connection is not established after 5 sec, the callback line45 will set isConnected=false
    isConnected = true
    socket.connect(timeoutAfter: 5, withHandler: {
      self.isConnected = false
      self.socket.disconnect()
      print("could not connect, call back is called and isConnected set to false")
      return
    })

  }

  func closeConnection(){
    socket.disconnect()
  }


//  func connectToServer()async throws{
//    socket.on(clientEvent: .connect) { data, acknowledgement in
//      print("socket connected")
//    }
//    socket.on("serverResponding"){data, acknowledgement in
//      if let receivedData = data[0] as? String {
//        self.socket.emitWithAck("canUpdate", receivedData).timingOut(after: 0) { data in
//          if data.first as? String ?? "passed" == SocketAckStatus.noAck{
//            print("Timed out!!! Do something")
//          }
//          self.socket.emit("update", ["msg":receivedData])
//        }
//        acknowledgement.with("")
//      }
//
//
//    }
//
//    //    start timer
//    //    call sendMessage() every 5 sec
//
//  }

  func sendPacket(){
    sendMessage()
    socket.emit("message", message)
  }

  func sendMessage(){
     message = "Hello! This is packet \(packetNr)"
    packetNr += 1
  }
}
