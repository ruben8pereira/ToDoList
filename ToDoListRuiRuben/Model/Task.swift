//
//  Task.swift
//  ToDoListRuiRuben
//
//  Created by Rui Cruz and Rúben Pereira on 25/03/2025.
//
import Foundation

struct Task: Identifiable, Codable, Equatable {
    var id: Int
    var name: String
    var description: String
    var category: Int
    var image: String
    
    static func ==(lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
}

// Enumeração para categorias
enum TaskCategory: Int, CaseIterable, Codable {
    case personal = 1
    case work
    case school
    case shopping
    case health
    
    var name: String {
        switch self {
        case .personal: return "Pessoal"
        case .work: return "Trabalho"
        case .school: return "Escola"
        case .shopping: return "Compras"
        case .health: return "Saúde"
        }
    }
    
    var icon: String {
        switch self {
        case .personal: return "person.fill"
        case .work: return "briefcase.fill"
        case .school: return "book.fill"
        case .shopping: return "cart.fill"
        case .health: return "heart.fill"
        }
    }
}

// Array de imagens disponíveis para tarefas
struct TaskImages {
    static let images = [
        "checkmark.circle",
        "star.fill",
        "bell.fill",
        "flag.fill",
        "calendar",
        "doc.fill",
        "folder.fill",
        "paperplane.fill",
        "tray.fill",
        "pencil"
    ]
}
