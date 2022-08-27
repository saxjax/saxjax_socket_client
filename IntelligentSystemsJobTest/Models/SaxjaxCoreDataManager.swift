//
//  SaxjaxCoreDataManager.swift
//  IntelligentSystemsJobTest
//
//  Created by Jakob Skov Søndergård on 22/08/2022.
//

import Foundation
import CoreData
import SwiftUI


class SaxjaxCoreDataManager:ObservableObject {
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    animation: .default)
  var items: FetchedResults<Item>

  func addItem(id:Int32,message msg:String?=nil) {
//    withAnimation {
      let newItem = Item(context: viewContext)
      newItem.id = id
      newItem.timestamp = Date()
      newItem.message = msg

      do {
        try viewContext.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
//    }
  }

  func deleteItems(offsets: IndexSet) {
//    withAnimation {
      offsets.map { items[$0] }.forEach(viewContext.delete)

      do {
        try viewContext.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
//    }
  }

  private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
  }()

}


  

