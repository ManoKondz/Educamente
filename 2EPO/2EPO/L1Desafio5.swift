import SwiftUI
import AVFoundation

struct L1Desafio5: View {
    @State private var showingIncorrectSheet = false
    @State private var showingCorrectSheet = false
    @State private var selectedOption = ""
    @State private var navigateToNextScreen = false
    @State private var isCorrect = false
    @State private var respostacerta = "Com Mãos, O Mundo Se Conecta"
    private let voiceSynthesizer = VoiceSynthesizer()

    func textForIndex(_ index: Int) -> String {
        switch index {
        case 0: return "Com Mões, Tudo Fica Melhor"
        case 1: return "Com Mãos, O Mundo Se Conecta"
        case 2: return "Com Moisés, Tudo Fica Melhor"
        case 3: return "Com Mãoses, O Mundo Se Conecta"
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
                        .frame(width: 360, height: 25)
                }
                .padding(.horizontal)

                Text("Após concluir uma série de cartazes para participar do movimento sobre a língua inglesa, o grupo das mãos precisa escolher um `slogan`.")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .font(.system(size: 16))

                Image("L1Desafio5")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 200)
                    .padding()

                Text("Selecione o `slogan` mais apropriado.")
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
                    voiceSynthesizer.speak("Após concluir uma série de cartazes para participar do movimento sobre a língua inglesa, o grupo das mãos precisa escolher um `slogan`.")
                    voiceSynthesizer.speak("Selecione o slogan mais apropriado.")
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
            TrilhaView()
        }
    }
}

#Preview {
    L1Desafio5()
}
