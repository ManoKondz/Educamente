//
//  L2Desafio3.swift
//  2EPO
//
//  Created by found on 10/09/24.
//
import SwiftUI

struct L2Desafio3: View {
    @State private var showingIncorrectSheet = false
    @State private var showingCorrectSheet = false
    @State private var selectedOption = ""
    @State private var navigateToNextScreen = false
    @State private var isCorrect = false
    @State private var respostacerta = "Água mole em pedra dura tanto bate até que fura"
    private let voiceSynthesizer = VoiceSynthesizer()

    func textForIndex(_ index: Int) -> String {
        switch index {
        case 0:
            return "Água mole em pedra dura tanto bate até que fura"
        case 1:
            return "Água de chuva em abril, cada gota vale um mil"
        case 2:
            return "Água que não corre, forma lodo e morre"
        case 3:
            return "Água que não bebes, fonte que não passas"
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
                            .frame(width: 216, height: 25)
                    }
                    .padding(.horizontal)

                    Text("Com base na situação representada na imagem, como você completaria o ditado popular apresentado no quadro negro?")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(height: 100)
                        .font(.system(size: 18))

                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 300, height: 200)

                        Text("Complete o ditado!")
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
                            voiceSynthesizer.speak("Com base na situação representada na imagem, como você completaria o ditado popular apresentado no quadro negro?")
                            voiceSynthesizer.speak("Complete o ditado")
                        }) {
                            Image(systemName: "speaker.wave.2.fill")
                                .frame(width: 120, height: 50)
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

                NavigationLink(destination: L2Desafio4(), isActive: $navigateToNextScreen) {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    L2Desafio3()
}
