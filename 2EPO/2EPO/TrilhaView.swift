//
//  TrilhaView.swift
//  2EPO
//
//  Created by found on 21/05/24.
//

import SwiftUI

struct TrilhaView: View {
    @State private var showingPopup = false
    @State private var selectedLesson = ""
    @State private var LicaoID = 0
    @State private var lessonName: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    HStack() {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text("João")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Aluno")
                                .font(.title3)
                        }
                    }
                    .padding()
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            ForEach(0..<6) { index in
                                HStack {
                                    if index % 2 == 0 {
                                        VStack {
                                            HStack {
                                                CircleIconView(index: index)
                                                    .onTapGesture {
                                                        self.selectedLesson = getLessonTitle(index: index)
                                                        self.showingPopup.toggle()
                                                    }
                                                Spacer() // Empurra a imagem para a esquerda
                                            }
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(index % 2 == 0 ? Color.black : Color.blue)
                                                .frame(width: 250, height: 20)
                                                .rotationEffect(.degrees(index % 2 == 0 ? 35 : -35))
                                                .zIndex(-1)
                                        }
                                    } else {
                                        VStack {
                                            HStack {
                                                Spacer() // Empurra a imagem para a direita
                                                CircleIconView(index: index)
                                                    .onTapGesture {
                                                        self.selectedLesson = getLessonTitle(index: index)
                                                        self.showingPopup.toggle()
                                                    }
                                            }
                                            if index < 5 {
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(index % 2 == 0 ? Color.black : Color.blue)
                                                    .frame(width: 250, height: 20)
                                                    .rotationEffect(.degrees(index % 2 == 0 ? 35 : -35))
                                                    .zIndex(-1)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.background)
                    }
                    .frame(maxHeight: .infinity)
                }
                .background(Color.menu)
                
                if showingPopup {
                    LessonPopupView(lessonName: selectedLesson, isShowingPopup: $showingPopup)
                }
            }
        }
        .tabItem {
            Image(systemName: "list.dash")
            Text("Trilha")
        }
    }
    
    func getLessonTitle(index: Int) -> String {
        switch index {
        case 0:
            return "Lição 1: A batalha pela verdadeira palavra."
        case 1:
            return "Lição 2: Através de Ditados Populares."
        case 2:
            return "Lição 3: O mistério do Ônibus."
        case 3:
            return "Lição 4: Lição Extra/Complementar."
        case 4:
            return "Lição 5: Lição Extra/Complementar."
        case 5:
            return "Lição 6: Lição Extra/Complementar."
        default:
            return "Lição \(index + 1)"
        }
    }
}

struct CircleIconView: View {
    var index: Int
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.trilhafundobotao)
                .frame(width: 100, height: 100)
            Image(getAssetName(index))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(.white)
        }
    }
    
    // Esta função retorna o nome do asset com base no índice
    func getAssetName(_ index: Int) -> String {
        switch index {
        case 0:
            return "BotaoL1Trilha"
        case 1:
            return "BotaoL2Trilha"
        case 2:
            return "BotaoL3Trilha"
        case 3:
            return "BotaoL4Trilha"
        case 4:
            return "BotaoL5Trilha"
        case 5:
            return "BotaoL6Trilha"
        default:
            return "BotaoL1Trilha" // Valor padrão, pode ajustar conforme necessário
        }
    }
}

struct LessonState {
    var path = [Int]()
    var erradas = [Int]()
}

struct LessonPopupView: View {
    @State private var LicaoID = 0
    
    var lessonName: String
    @Binding var isShowingPopup: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.isShowingPopup = false
                }) {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.green)
                }
                .padding(.leading, 20)
                .padding(.top, 20)
                Spacer()
            }
            
            Text(lessonName)
                .font(.title)
                .padding(.top, 20)
                .padding(.horizontal, 20)
                .onAppear {
                    updateLicaoID()
                }
            
            // Botões de navegação com NavigationLink
            if LicaoID == 1 {
                NavigationLink(destination: L1Desafio1()) {
                    navigationButton
                }
            } else if LicaoID == 2 {
                NavigationLink(destination: L2Desafio1()) {
                    navigationButton
                }
            } else {
                Text("Nenhuma lição disponível.")
            }
            
            Spacer()
        }
        .frame(width: 300, height: 300)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
        .padding(.top, 20)
    }
    
    // Botão de navegação reutilizável
    var navigationButton: some View {
        Image(systemName: "play.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .foregroundColor(.white)
            .padding()
            .background(Color.green)
            .clipShape(Circle())
    }
    
    // Função para atualizar o LicaoID com base no nome da lição
    func updateLicaoID() {
        if lessonName == "Lição 1: A batalha pela verdadeira palavra." {
            LicaoID = 1
        } else if lessonName == "Lição 2: Através de Ditados Populares." {
            LicaoID = 2
        } else {
            LicaoID = 0
        }
    }
}



#Preview {
    TabView {
        TrilhaView()
    }
}
