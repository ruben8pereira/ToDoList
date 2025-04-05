//
//  TaskManager.swift
//  ToDoListRuiRuben
//
//  Created by Rui Cruz and Rúben Pereira on 25/03/2025.
//

// Gerenciador das tarefas com persistência JSON

import Foundation
import SwiftUI

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = []
    private var nextId = 1
    
    init() {
        loadTasks()
    }
    
    // URL para o arquivo JSON
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func getTasksFileURL() -> URL {
        return getDocumentsDirectory().appendingPathComponent("tasks.json")
    }
    
    // Carregar tarefas do arquivo JSON
    func loadTasks() {
        let fileURL = getTasksFileURL()
        
        // Verificar se o arquivo existe
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                tasks = try decoder.decode([Task].self, from: data)
                updateNextId()
            } catch {
                print("Erro ao carregar tarefas: \(error)")
                // Criar algumas tarefas de exemplo na primeira execução
                createSampleTasks()
            }
        } else {
            // Se o arquivo não existe, criar tarefas de exemplo
            createSampleTasks()
        }
    }
    
    // Salvar tarefas no arquivo JSON
    func saveTasks() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(tasks)
            try data.write(to: getTasksFileURL())
        } catch {
            print("Erro ao salvar tarefas: \(error)")
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
        saveTasks()
    }
    
    // Atualizar uma tarefa existente
    func updateTask(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            saveTasks()
        }
    }
    
    // Remover uma tarefa
    func removeTask(task: Task) {
        tasks.removeAll { $0.id == task.id }
        saveTasks()
    }
    
    // Remover todas as tarefas
    func removeAllTasks() {
        tasks.removeAll()
        saveTasks()
    }
    
    // Criar tarefas de exemplo para a primeira execução
    private func createSampleTasks() {
        tasks = [
            Task(id: 1, name: "Comprar Pão", description: "Passar na padaria e comprar pão fresco", category: 4, image: "cart.fill"),
            Task(id: 2, name: "Enviar Relatório", description: "Finalizar e enviar o relatório trimestral", category: 2, image: "doc.fill"),
            Task(id: 3, name: "Estudar para o Exame", description: "Revisar capítulos 5-8 para o exame de iOS", category: 3, image: "book.fill")
        ]
        nextId = 4
        saveTasks()
    }
}
