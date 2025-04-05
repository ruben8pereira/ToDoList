//
//  AboutView.swift
//  ToDoListRuiRuben
//
//  Created by Rui Cruz and Rúben Pereira on 25/03/2025.
//

// Informações sobre a app e seus criadores

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 30) {
                // Logo da app
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.blue, .purple]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 120, height: 120)
                    
                    Image(systemName: "list.bullet.clipboard.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                }
                .padding(.top, 40)
                
                Text("Lista de Tarefas")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Informações do projeto
                VStack(alignment: .leading, spacing: 16) {
                    sectionHeader("Criador")
                    
                    infoItem(icon: "person.fill", title: "Nome", detail: "Rui Cruz")
                    
                    infoItem(icon: "person.fill", title: "Nome", detail: "Rúben Pereira")
                    
                    Divider()
                    
                    sectionHeader("Elementos Adicionais")
                    
                    infoItem(icon: "paintpalette.fill", title: "UI/UX", detail: "Cores personalizadas e gradientes para melhorar a experiência visual")
                    
                    infoItem(icon: "wand.and.stars", title: "Animações", detail: "Transições animadas entre views e feedback visual nos botões")
                    
                    infoItem(icon: "trash.slash.fill", title: "Confirmação", detail: "Diálogos de confirmação para ações destrutivas")
                    
                    Divider()
                    
                    sectionHeader("Autoavaliação")
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Este projeto implementa todos os requisitos solicitados:")
                            .fontWeight(.medium)
                        
                        Text("• Lista completa de tarefas com persistência em JSON")
                        Text("• Adição, edição e remoção de tarefas")
                        Text("• Categorização e uso de SF Symbols")
                        Text("• Interface intuitiva e agradável ao utilizador")
                        
                        HStack {
                            Text("Nota autoatribuída:")
                                .fontWeight(.medium)
                            Text("18 valores")
                                .fontWeight(.bold)
                        }
                        .padding(.top, 8)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Text("© \(Calendar.current.component(.year, from: Date())) - Trabalho Prático iOS")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
            }
        }
        .navigationTitle("Sobre")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Funções auxiliares para criar componentes reutilizáveis
    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.secondary)
            .padding(.bottom, 4)
    }
    
    private func infoItem(icon: String, title: String, detail: String) -> some View {
        HStack(alignment: .top) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24)
            
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.medium)
                
                Text(detail)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
