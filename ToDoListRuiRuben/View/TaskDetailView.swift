//
//  TaskDetailView.swift
//  ToDoListRuiRuben
//
//  Created by Rui Cruz and Rúben Pereira on 25/03/2025.
//

// View de detalhes da tarefa

import SwiftUI

struct TaskDetailView: View {
    let taskId: Int
    @EnvironmentObject var taskManager: TaskManager
    @State private var showEditTask = false
    @Environment(\.dismiss) private var dismiss
    @State private var showDeleteConfirmation = false
    
    // Verificar a tarefa atual com base no ID
    private var task: Task {
        if let task = taskManager.tasks.first(where: { $0.id == taskId }) {
            return task
        }
        // Fallback para evitar crash da aplicação
        return Task(id: -1, name: "Tarefa não encontrada", description: "", category: 1, image: "exclamationmark.triangle")
    }
    
    var body: some View {
        ZStack {
            // Background com gradiente insipirado nas cores do CESAE Digital
            LinearGradient(gradient:
                           Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.2)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Cabeçalho da tarefa
                    HStack {
                        ZStack {
                            Circle()
                                .fill(getCategoryColor(for: task.category).opacity(0.2))
                                .frame(width: 80, height: 80)
                            
                            Image(systemName: task.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(getCategoryColor(for: task.category))
                        }
                        
                        VStack(alignment: .leading) {
                            Text(task.name)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            HStack {
                                Image(systemName: getCategoryIcon(for: task.category))
                                Text(getCategoryName(for: task.category))
                            }
                            .foregroundColor(.secondary)
                            .padding(.top, 1)
                        }
                        .padding(.leading)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(15)
                    .shadow(radius: 2)
                    
                    // Descrição da tarefa
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Descrição")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        Text(task.description)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(15)
                    .shadow(radius: 2)
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle("Detalhes da Tarefa")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showEditTask = true
                } label: {
                    Text("Editar")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showDeleteConfirmation = true
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
        }
        .sheet(isPresented: $showEditTask) {
            NavigationStack {
                TaskFormView(mode: .edit(task))
            }
        }
        .alert("Eliminar Tarefa", isPresented: $showDeleteConfirmation) {
            Button("Cancelar", role: .cancel) { }
            Button("Eliminar", role: .destructive) {
                taskManager.removeTask(task: task)
                dismiss()
            }
        } message: {
            Text("Tem a certeza que deseja eliminar esta tarefa?")
        }
    }
    
    // Funções auxiliares para obter informações sobre as categorias
    func getCategoryName(for categoryId: Int) -> String {
        if let category = TaskCategory(rawValue: categoryId) {
            return category.name
        }
        return "Desconhecida"
    }
    
    func getCategoryIcon(for categoryId: Int) -> String {
        if let category = TaskCategory(rawValue: categoryId) {
            return category.icon
        }
        return "questionmark"
    }
    
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
    NavigationStack {
        TaskDetailView(taskId: 1)
            .environmentObject(TaskManager())
    }
}
