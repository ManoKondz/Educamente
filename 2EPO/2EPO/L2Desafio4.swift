// No momento que este código foi escrito só 3 pessoas sabiam como isso funcionava. O Elbston, o Otávio e Deus. Neste momento, só deus sabe.
//
//  L2Desafio4.swift
//  2EPO
//
//  Created by found on 10/09/24.
//
import SwiftUI

struct L2Desafio4: View {
    
    //@Binding var state: LessonState
    
    @State private var showingPopup = false
    @State private var selectedOption = ""
    @State private var navigateToNextScreen = false
    @State private var isCorrect = false
    @State private var showingSheet = false
    @State private var respostacerta = "Meia palavra basta"
    private let voiceSynthesizer = VoiceSynthesizer()

    
    func textForIndex(_ index: Int) -> String {
        switch index {
        case 0:
            return "Uma imagem vale mais do que mil palavras"
        case 1:
            return "Meia palavra basta"
        case 2:
            return "O silêncio é ouro"
        case 3:
            return "O barulho é prata"
        default:
            return ""
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.menu // Cor de fundo aplicada a toda a tela
                    .edgesIgnoringSafeArea(.all) // Garante que a cor preencha toda a tela
                
                VStack {
                    HStack {
                        Spacer()
                    }
                    .padding()
                    
                    // Barra de progresso
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.barcolor)
                            .frame(width: 360,height: 25) // Define altura da barra de fundo
                        
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.progressBar)
                            .frame(width: 360, height: 25) // A largura é ajustada com base no progresso
                    }
                    .padding(.horizontal)
                    
                    Text("O Professor escreveu no quadro branco o início de um provérbio:”Para um bom entendedor ,__”.Como você completaria esse provérbio para ganhar pontos ?")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(height: 120)
                        .font(.system(size: 18))
                        .layoutPriority(1)
                    
                    VStack{
                        // Retângulo branco
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 300, height: 200)
                        
                        
                        Text("Complete o provérbio !")
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        // Caixa verde das respostas
                        VStack(spacing: 0) {
                            ForEach(0..<4, id: \.self) { index in
                                Button(action: {
                                    // Logica para saber se a resposta escolhida é a certa
                                    if selectedOption != respostacerta{
                                        isCorrect = false
                                    } else{
                                        isCorrect = true
                                    }
                                    showingSheet = true
                                    selectedOption = textForIndex(index)
                                }) {
                                    Text(textForIndex(index))
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.center) // Usado para ajustar o alinhamento do texto
//                                        .lineLimit(2) // comando para permitir que o texto ocupe várias linhas
                                        .minimumScaleFactor(0.9) // Reduz o tamanho do texto conforme
//                                        .padding(.vertical, 5)
                                        .frame(height: 50)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.botaoOpcao)
                                        .cornerRadius(10)                                }
                                
                                if index < 3 {
                                    Divider()
                                        .background(Color("botões"))                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.blue, lineWidth: 2)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.botaoOpcao)
                                )
                        )
                        .padding(.bottom, 20)
                        
                        // Botão de som
                        Button(action: {
                            // Ação do botão de som
                            voiceSynthesizer.speak("O Professor escreveu no quadro branco o início de um provérbio:”Para um bom entendedor ,__”.Como você completaria esse provérbio para ganhar pontos ?")
                            voiceSynthesizer.speak("Complete o provérbio!")

                        }) {
                            Image(systemName: "speaker.wave.2.fill")
                                .frame(width: 100, height: 40)
                                .padding()
                                .background(Color.botaoPadrao)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .sheet(isPresented: $showingSheet) {
                        CustomSheetView(isCorrect: isCorrect, onDismiss: {
                            showingSheet = false
                            navigateToNextScreen = true
                        })
                        .presentationDetents([.fraction(0.25)]) // Ajusta a altura da sheet para 25% da tela
                        .background(Color.blue) // Define a cor de fundo da sheet
                    }
                    
                    NavigationLink(value: navigateToNextScreen)
                                        {
                                        EmptyView()
                                    }
                                        .navigationDestination(isPresented:$navigateToNextScreen){
                                            L2Desafio5()
                                        }

                    
                    
//                    .onChange(of: navigateToNextScreen) { newValue in
//                        if newValue {
//                            if isCorrect == false {
//                                state.erradas.append(1)
//                            }
//                            
//                            // VOLTAR PARA QUESTOES ERRADAS
//                            if state.path.count >= 5 {
//                                
//                                if state.erradas.isEmpty {
//                                    state.path.removeAll()
//                                } else {
//                                    // PEGA A PRIMEIRA LIÇÃO ERRADA E REMOVE DAS ERRADAS
//                                    let first = state.erradas.removeFirst()
//                                    state.path.append(first)
//                                }
//                            } else {
//                                // VAI PARA PROXIMA LICAO
//                                state.path.append(2)
//                            }
//                        }
//                    }
                    
                }
            }
        }
    }
}
struct CustomPopupView9: View {
    var isCorrect: Bool
    @Binding var showing: Bool
    @Binding var navigateToNextScreen: Bool
    private let voiceSynthesizer = VoiceSynthesizer()

    
    var body: some View {
        if showing {
            VStack {
                HStack {
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading) {
                        Text(isCorrect ? "Excelente! Parabéns!" : "Ops... Na próxima dá certo")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        voiceSynthesizer.speak(isCorrect ? "Excelente! Parabéns!" : "Ôpis... Na próxima dá certo")
                    }){
                        Image(systemName: "speaker.wave.3.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(15)
                .padding()
                
                Button(action: {
                    showing = false
                    navigateToNextScreen = true
                }) {
                    Image(systemName: "forward.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .padding(.horizontal, 50)
            }
            .transition(.move(edge: .bottom))
            .animation(.easeInOut, value: showing)
        }
    }
}
#Preview {
    L2Desafio4()
}
