//
//  TaskFormView.swift
//  ToDoListRuiRuben
//
//  Created by Rui Cruz and Rúben Pereira on 25/03/2025.
//

// Formulário para adicionar ou editar tarefas

import SwiftUI

enum FormMode {
    case add
    case edit(Task)
}

struct TaskFormView: View {
    @EnvironmentObject var taskManager: TaskManager
    @Environment(\.dismiss) private var dismiss
    
    let mode: FormMode
    
    @State private var taskName = ""
    @State private var taskDescription = ""
    @State private var selectedCategory = 1
    @State private var selectedImage = "checkmark.circle"
    
    // Grid layout para seleção de imagens
    private let columns = [
        GridItem(.adaptive(minimum: 60))
    ]
    
    var body: some View {
        Form {
            Section(header: Text("Informações da Tarefa")) {
                TextField("Tarefa", text: $taskName)
                
                VStack(alignment: .leading) {
                    Text("Descrição")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    TextEditor(text: $taskDescription)
                        .frame(minHeight: 100)
                }
            }
            
            Section(header: Text("Categoria")) {
                Picker("Categoria", selection: $selectedCategory) {
                    ForEach(TaskCategory.allCases, id: \.rawValue) { category in
                        Label(category.name, systemImage: category.icon)
                            .tag(category.rawValue)
                    }
                }
            }
            
            Section(header: Text("Imagem")) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(TaskImages.images, id: \.self) { image in
                        ZStack {
                            Circle()
                                .fill(selectedImage == image ?
                                      .blue.opacity(0.2) : Color(UIColor.systemBackground))
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Circle()
                                        .stroke(selectedImage == image ? .blue : .gray, lineWidth: 2)
                                )
                            
                            Image(systemName: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(selectedImage == image ? .blue : .gray)
                        }
                        .onTapGesture {
                            selectedImage = image
                        }
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationTitle(isEditMode ? "Editar Tarefa" : "Nova Tarefa")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancelar") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditMode ? "Guardar" : "Adicionar") {
                    if isEditMode {
                        if case .edit(let task) = mode {
                            let updatedTask = Task(
                                id: task.id,
                                name: taskName,
                                description: taskDescription,
                                category: selectedCategory,
                                image: selectedImage
                            )
                            taskManager.updateTask(task: updatedTask)
                        }
                    } else {
                        taskManager.addTask(
                            name: taskName,
                            description: taskDescription,
                            category: selectedCategory,
                            image: selectedImage
                        )
                    }
                    dismiss()
                }
                .disabled(taskName.isEmpty)
            }
        }
        .onAppear {
            if case .edit(let task) = mode {
                taskName = task.name
                taskDescription = task.description
                selectedCategory = task.category
                selectedImage = task.image
            }
        }
    }
    
    private var isEditMode: Bool {
        if case .edit = mode {
            return true
        }
        return false
    }
}

#Preview {
    NavigationStack {
        TaskFormView(mode: .add)
            .environmentObject(TaskManager())
    }
}
