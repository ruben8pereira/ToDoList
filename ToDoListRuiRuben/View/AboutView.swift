//
//  AboutView.swift
//  ToDoListRuiRuben
//
//  Created by Rui Cruz and Rúben Pereira on 25/03/2025.
//

// Informações sobre a aplicsção

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 30) {
                // Logo da aplicação
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
                    // Secção dos Criadores
                    Text("Criadores")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 4)
                    
                    // Informação - Rui Cruz
                    HStack(alignment: .top) {
                        Image(systemName: "person.fill")
                            .foregroundColor(.blue)
                            .frame(width: 24)
                        
                        VStack(alignment: .leading) {
                            Text("Rui Cruz")
                                .fontWeight(.medium)
                            
                            Text("rui.cruz.prt_a@msft.cesae.pt")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    // Informação - Rúben Pereira
                    HStack(alignment: .top) {
                        Image(systemName: "person.fill")
                            .foregroundColor(.blue)
                            .frame(width: 24)
                        
                        VStack(alignment: .leading) {
                            Text("Rúben Pereira")
                                .fontWeight(.medium)
                            
                            Text("ruben.pereira.prt_a@msft.cesae.pt")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    Divider()
                    
                    // Secção Elementos Adicionais
                    Text("Elementos Adicionais")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 4)
                    
                    // UI/UX
                    HStack(alignment: .top) {
                        Image(systemName: "paintpalette.fill")
                            .foregroundColor(.blue)
                            .frame(width: 24)
                        
                        VStack(alignment: .leading) {
                            Text("UI/UX")
                                .fontWeight(.medium)
                            
                            Text("Cores personalizadas e gradiente inspirado no CESAE Digital para melhorar a experiência visual")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    // Animações
                    HStack(alignment: .top) {
                        Image(systemName: "wand.and.stars")
                            .foregroundColor(.blue)
                            .frame(width: 24)
                        
                        VStack(alignment: .leading) {
                            Text("Animações")
                                .fontWeight(.medium)
                            
                            Text("Transições animadas entre views e feedback visual nos botões")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    // Confirmação
                    HStack(alignment: .top) {
                        Image(systemName: "trash.slash.fill")
                            .foregroundColor(.blue)
                            .frame(width: 24)
                        
                        VStack(alignment: .leading) {
                            Text("Confirmação")
                                .fontWeight(.medium)
                            
                            Text("Diálogos de confirmação para ações destrutivas")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    Divider()
                    
                    // Secção Autoavaliação
                    Text("Autoavaliação dos Criadores")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 4)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Este projeto implementa todos os requisitos solicitados:")
                            .fontWeight(.medium)
                        
                        Text("• Adição, edição e remoção de tarefas")
                        Text("• Categorização e uso de SF Symbols")
                        Text("• Interface intuitiva e agradável ao utilizador")
                        
                        HStack {
                            Text("Autoavaliação (Rui):")
                                .fontWeight(.medium)
                            Text("19 valores")
                                .fontWeight(.bold)
                        }
                        .padding(.top, 10)
                        
                        HStack {
                            Text("Autoavaliação (Rúben):")
                                .fontWeight(.medium)
                            Text("19 valores")
                                .fontWeight(.bold)
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Text("2025 - Trabalho Prático iOS")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
            }
        }
        .navigationTitle("Sobre")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
