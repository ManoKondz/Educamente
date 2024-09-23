import SwiftUI

struct L1Desafio2: View {

    @State private var showingIncorrectSheet = false
    @State private var showingCorrectSheet = false
    @State private var words: [String] = ["Mões", "Universo", "Classes", "Pessoas", "Escolha", "Mãos", "Mundo", "Planeta", "Vidas"]
    @State private var showingPopup = false
    @State private var draggedWord: String? = nil
    @State private var resposta1 = ""
    @State private var resposta2 = ""
    @State private var resposta3 = ""
    @State private var navigateToNextScreen = false
    @State private var isCorrect = false
    private let voiceSynthesizer = VoiceSynthesizer()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.menu
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .leading) {
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
                            .frame(width: 144, height: 25)
                    }
                    .padding(.horizontal)

                    Text("Ajude Ana a completar seu cartaz escolhendo as opções certas, Ela solicita auxílio para a conclusão de três frases cruciais.")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()

                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 300, height: 200)
                            .overlay(
                                VStack {
                                    fraseCompletaView()
                                }
                            )

                        Text("Escolha as palavras corretas!")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding(.top)

                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.botaoOpcao)
                            VStack {
                                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 10), count: 3), spacing: 10) {
                                    ForEach(words, id: \.self) { word in
                                        Text(word)
                                            .frame(maxWidth: .infinity, minHeight: 50)
                                            .background(Color.botaoL1D2)
                                            .cornerRadius(10)
                                            .foregroundColor(.white)
                                            .onDrag {
                                                self.draggedWord = word
                                                return NSItemProvider(object: word as NSString)
                                            }
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    .padding(.horizontal)

                    Spacer()

                    HStack {
                        Button(action: {
                            voiceSynthesizer.speak("Ajude Ana a completar seu cartaz escolhendo as opções certas, Ela solicita auxílio para a conclusão de três frases cruciais.")
                            voiceSynthesizer.speak("Escolha as palavras corretas")
                        }) {
                            Image(systemName: "speaker.3.fill")
                                .frame(width: 100)
                                .padding()
                                .background(Color.botaoPadrao)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }

                        Spacer()

                        Button(action: {
                            isCorrect = verificarRespostas()
                            if isCorrect {
                                showingCorrectSheet = true
                            } else {
                                showingIncorrectSheet = true
                            }
                        }) {
                            Image(systemName: "hand.thumbsup.fill")
                                .frame(width: 100)
                                .padding()
                                .background(Color.botaoPadrao)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 55)
                }
                .padding(.bottom)

                .sheet(isPresented: $showingCorrectSheet) {
                    CustomSheetViewTrue(onDismiss: {
                        showingCorrectSheet = false
                        navigateToNextScreen = true
                    })
                    .presentationDetents([.fraction(0.25)]) // Ajusta a altura da sheet para 25% da tela
                }

                .sheet(isPresented: $showingIncorrectSheet) {
                    CustomSheetViewFalse(onDismiss: {
                        showingIncorrectSheet = false
                        navigateToNextScreen = true
                    })
                    .presentationDetents([.fraction(0.25)]) // Ajusta a altura da sheet para 25% da tela
                }

                NavigationLink(isActive: $navigateToNextScreen) {
                    L1Desafio3()
                } label: {
                    EmptyView()
                }
            }
        }
    }

    func verificarRespostas() -> Bool {
        let isResposta1Correta = resposta1 == "Mãos"
        let isResposta2Correta = resposta2 == "Pessoas"
        let isResposta3Correta = resposta3 == "Mundo"

        return isResposta1Correta && isResposta2Correta && isResposta3Correta
    }

    @ViewBuilder
    func fraseCompletaView() -> some View {
        VStack(alignment: .leading) {
            fraseCompletarView(textoBase: "Lute pelas", espaco: $resposta1)
            fraseCompletarView(textoBase: "O poder das", espaco: $resposta2, textoPosEspaco: "muda tudo")
            fraseCompletarView(textoBase: "O seu voto mudará o", espaco: $resposta3)
        }
        .padding()
    }

    func fraseCompletarView(textoBase: String, espaco: Binding<String>, textoPosEspaco: String = "") -> some View {
        HStack {
            Text(textoBase)
                .font(.title3)
                .foregroundColor(.black)

            Text(espaco.wrappedValue.isEmpty ? "________" : espaco.wrappedValue)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(espaco.wrappedValue.isEmpty ? .gray : .black)
                .onDrop(of: [.text], isTargeted: nil) { providers in
                    if let provider = providers.first {
                        provider.loadObject(ofClass: String.self) { object, _ in
                            if let word = object as? String {
                                DispatchQueue.main.async {
                                    if !espaco.wrappedValue.isEmpty {
                                        words.append(espaco.wrappedValue)
                                    }
                                    espaco.wrappedValue = word
                                    if let index = words.firstIndex(of: word) {
                                        words.remove(at: index)
                                    }
                                }
                            }
                        }
                        return true
                    }
                    return false
                }
                .onTapGesture {
                    if !espaco.wrappedValue.isEmpty {
                        words.append(espaco.wrappedValue)
                        espaco.wrappedValue = ""
                    }
                }

            if !textoPosEspaco.isEmpty {
                Text(textoPosEspaco)
                    .font(.title2)
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    L1Desafio2()
}
