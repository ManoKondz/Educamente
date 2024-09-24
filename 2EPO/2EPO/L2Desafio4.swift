//
//  L2Desafio4.swift
//  2EPO
//
//  Created by found on 10/09/24.
//
import SwiftUI

struct L2Desafio4: View {
    @State private var showingIncorrectSheet = false
    @State private var showingCorrectSheet = false
    @State private var selectedOption = ""
    @State private var navigateToNextScreen = false
    @State private var isCorrect = false
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
                Color.menu
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    HStack {
                        Spacer()
                    }
                    .padding()

                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.barcolor)
                            .frame(width: 360, height: 25)

                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.progressBar)
                            .frame(width: 360, height: 25)
                    }
                    .padding(.horizontal)

                    Text("O Professor escreveu no quadro branco o início de um provérbio: 'Para um bom entendedor, __'. Como você completaria esse provérbio para ganhar pontos?")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(height: 120)
                        .font(.system(size: 18))

                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 300, height: 200)

                        Text("Complete o provérbio!")
                            .foregroundColor(.white)
                            .padding(.top, 10)

                        VStack(spacing: 0) {
                            ForEach(0..<4, id: \.self) { index in
                                Button(action: {
                                    selectedOption = textForIndex(index)
                                    isCorrect = (selectedOption == respostacerta)
                                    if isCorrect {
                                        showingCorrectSheet = true
                                    } else {
                                        showingIncorrectSheet = true
                                    }
                                }) {
                                    Text(textForIndex(index))
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.center)
                                        .frame(height: 50)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.botaoOpcao)
                                        .cornerRadius(10)
                                }

                                if index < 3 {
                                    Divider()
                                        .background(Color("botões"))
                                }
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

                        Button(action: {
                            voiceSynthesizer.speak("O Professor escreveu no quadro branco o início de um provérbio: 'Para um bom entendedor, __'. Como você completaria esse provérbio para ganhar pontos?")
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

                    .sheet(isPresented: $showingCorrectSheet) {
                        CustomSheetViewTrue(onDismiss: {
                            showingCorrectSheet = false
                            navigateToNextScreen = true
                        })
                        .presentationDetents([.fraction(0.25)])
                    }
                    .sheet(isPresented: $showingIncorrectSheet) {
                        CustomSheetViewFalse(onDismiss: {
                            showingIncorrectSheet = false
                            navigateToNextScreen = true
                        })
                        .presentationDetents([.fraction(0.25)])
                    }
                    
                }

                NavigationLink(destination: L2Desafio5(), isActive: $navigateToNextScreen) {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    L2Desafio4()
}
