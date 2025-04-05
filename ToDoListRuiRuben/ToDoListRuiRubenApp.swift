//
//  ToDoListRuiRubenApp.swift
//  ToDoListRuiRuben
//
//  Created by Rui Cruz and Rúben Pereira on 25/03/2025.
//

import SwiftUI

@main
struct ToDoListRuiRubenApp: App {
    @StateObject private var taskManager = TaskManager()
       
       var body: some Scene {
           WindowGroup {
               ContentView()
                   .environmentObject(taskManager)
           }
       }
   }
