//
//  ContentView.swift
//  ToDoListRuiRuben
//
//  Created by Rui Cruz and Rúben Pereira on 25/03/2025.
//

// View principal da aplicação

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var taskManager: TaskManager
    @State private var showAddTask = false
    @State private var showDeleteAllConfirmation = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background com camadas (ZStack)
                LinearGradient(gradient:
                               Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.3)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .ignoresSafeArea()
                
                VStack {
                    if taskManager.tasks.isEmpty {
                        ContentUnavailableView {
                            Label("Nenhuma Tarefa", systemImage: "list.bullet.rectangle.portrait")
                        } description: {
                            Text("Adicione tarefas tocando no botão +")
                        }
                    } else {
                        List {
                            ForEach(taskManager.tasks) { task in
                                NavigationLink(destination: TaskDetailView(taskId: task.id)) {
                                    TaskRowView(task: task)
                                }
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        taskManager.removeTask(task: task)
                                    } label: {
                                        Label("Eliminar", systemImage: "trash")
                                    }
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .navigationTitle("Lista de Tarefas")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showDeleteAllConfirmation = true
                    } label: {
                        Label("Eliminar Todas", systemImage: "trash")
                            .foregroundColor(.red)
                    }
                    .disabled(taskManager.tasks.isEmpty)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddTask = true
                    } label: {
                        Label("Adicionar", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AboutView()) {
                        Label("Sobre", systemImage: "info.circle")
                    }
                }
            }
            .sheet(isPresented: $showAddTask) {
                NavigationStack {
                    TaskFormView(mode: .add)
                }
            }
            .alert("Eliminar Todas as Tarefas", isPresented: $showDeleteAllConfirmation) {
                Button("Cancelar", role: .cancel) { }
                Button("Eliminar", role: .destructive) {
                    taskManager.removeAllTasks()
                }
            } message: {
                Text("Esta ação não pode ser revertida.")
            }
        }
    }
}

struct TaskRowView: View {
    let task: Task
    
    var body: some View {
        HStack {
            Image(systemName: task.image)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(getCategoryColor(for: task.category))
                .padding(8)
                .background(getCategoryColor(for: task.category).opacity(0.2))
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(task.name)
                    .font(.headline)
                
                Text(CategoryName(for: task.category))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    // Função para obter o nome da categoria
    func CategoryName(for categoryId: Int) -> String {
        if let category = TaskCategory(rawValue: categoryId) {
            return category.name
        }
        return "Desconhecida"
    }
    
    // Função para obter a cor da categoria
    func getCategoryColor(for categoryId: Int) -> Color {
        if let category = TaskCategory(rawValue: categoryId) {
            switch category {
            case .personal: return .blue
            case .work: return .orange
            case .school: return .green
            case .shopping: return .purple
            case .health: return .red
            }
        }
        return .gray
    }
}

#Preview {
    ContentView()
        .environmentObject(TaskManager())
}
