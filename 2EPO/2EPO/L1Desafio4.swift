import SwiftUI
import AVFoundation

struct L1Desafio4: View {
    @State private var showingIncorrectSheet = false
    @State private var showingCorrectSheet = false
    @State private var selectedOption = ""
    @State private var navigateToNextScreen = false
    @State private var isCorrect = false
    @State private var respostacerta = "Para seguir a norma culta padrão do português"
    private let voiceSynthesizer = VoiceSynthesizer()

    func textForIndex(_ index: Int) -> String {
        switch index {
        case 0: return "Para seguir a norma culta padrão do português"
        case 1: return "É importante para o equilíbrio do mundo"
        case 2: return "Agradar uma parcela da sociedade"
        case 3: return "Você ganha superpoderes linguísticos"
        default: return ""
        }
    }

    var body: some View {
        ZStack {
            Color.menu.edgesIgnoringSafeArea(.all)

            VStack {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 60)
                        .fill(Color.barcolor)
                        .frame(width: 360, height: 25)
                    RoundedRectangle(cornerRadius: 60)
                        .fill(Color.progressBar)
                        .frame(width: 288, height: 25)
                }
                .padding(.horizontal)

                Text("Auxilie os participantes da manifestação a elucidar as concepções da criança.")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .font(.system(size: 16))

                Image("L1Desafio4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 200)
                    .padding()

                Text("Escolha a alternativa correta!")
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
                                .font(.system(size: 15))
                                .foregroundColor(.black)
                                .padding()
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
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.botaoOpcao))
                )

                Button(action: {
                    voiceSynthesizer.speak("Auxilie os participantes da manifestação a elucidar as concepções da criança.")
                    voiceSynthesizer.speak("Escolha a alternativa correta!")
                }) {
                    Image(systemName: "speaker.wave.2.fill")
                        .frame(width: 120, height: 50)
                        .padding()
                        .background(Color.botaoPadrao)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
            }
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
        .navigationDestination(isPresented: $navigateToNextScreen) {
            L1Desafio5()
        }
    }
}

#Preview {
    L1Desafio4()
}
