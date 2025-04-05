//
//  TaskManager.swift
//  ToDoListRuiRuben
//
//  Created by Rui Cruz and Rúben Pereira on 25/03/2025.
//

// Gestor das tarefas

import Foundation
import SwiftUI

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = []
    private var nextId = 1
    
    init() {
        decodeJSONData()
    }
    
    // Decode dos dados do ficheiro JSON
    func decodeJSONData() {
        if let url = Bundle.main.url(forResource: "tasks", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                tasks = try decoder.decode([Task].self, from: data)
                updateNextId()
                print("Tarefas carregadas: \(tasks.count)")
            } catch {
                print("Erro ao decodificar dados JSON: \(error)")
                createSampleTasks()
            }
        } else {
            print("Arquivo JSON não encontrado.")
            createSampleTasks()
        }
    }
    
    // Atualizar o próximo ID disponível
    private func updateNextId() {
        if let maxId = tasks.map({ $0.id }).max() {
            nextId = maxId + 1
        } else {
            nextId = 1
        }
    }
    
    // Adicionar uma nova tarefa
    func addTask(name: String, description: String, category: Int, image: String) {
        let newTask = Task(id: nextId, name: name, description: description, category: category, image: image)
        tasks.append(newTask)
        nextId += 1
    }
    
    // Atualizar uma tarefa existente
    func updateTask(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
        }
    }
    
    // Remover uma tarefa
    func removeTask(task: Task) {
        tasks.removeAll { $0.id == task.id }
    }
    
    // Remover todas as tarefas
    func removeAllTasks() {
        tasks.removeAll()
    }
    
    // Criar tarefas de exemplo para a primeira execução
    private func createSampleTasks() {
        tasks = [
            Task(id: 1, name: "Comprar Pão", description: "Passar na padaria e comprar pão fresco", category: 4, image: "cart.fill"),
            Task(id: 2, name: "Entregar Projeto", description: "Entregar o projeto final do curso de Software Developer do CESAE Digital: Pixel Perfect: Inspection Reports", category: 2, image: "doc.fill"),
            Task(id: 3, name: "Estudar para o Exame", description: "Rever os PDFs para o exame de iOS", category: 3, image: "book.fill")
        ]
        nextId = 4
    }
}
