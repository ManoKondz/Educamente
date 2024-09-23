import SwiftUI

struct L2Desafio5: View {
    @State private var showingIncorrectSheet = false
    @State private var showingCorrectSheet = false
    @State private var selectedOption = ""
    @State private var navigateToNextScreen = false
    private let respostacerta = "Tudo perde"

    func textForIndex(_ index: Int) -> String {
        switch index {
        case 0:
            return "Tudo vende"
        case 1:
            return "Tudo compra"
        case 2:
            return "Tudo ganha"
        case 3:
            return respostacerta
        default:
            return ""
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.menu.edgesIgnoringSafeArea(.all)
                VStack {
                    // Barra de progresso
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.barcolor)
                            .frame(width: 360, height: 25)

                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.progressBar)
                            .frame(width: 360, height: 25)
                    }
                    .padding(.horizontal)

                    Text("A mamãe começou o provérbio com “quem tudo quer __________”. Como você ajudaria ela a completar esse provérbio para ganhar os deliciosos biscoitos?")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(height: 120)
                        .font(.system(size: 18))
                        .layoutPriority(1)

                    VStack {
                        // Retângulo branco
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 300, height: 200)

                        Text("Complete o provérbio!")
                            .foregroundColor(.white)
                            .padding(.top, 10)

                        // Caixa verde das respostas
                        VStack(spacing: 0) {
                            ForEach(0..<4, id: \.self) { index in
                                Button(action: {
                                    selectedOption = textForIndex(index)
                                    if selectedOption == respostacerta {
                                        showingCorrectSheet = true
                                    } else {
                                        showingIncorrectSheet = true
                                    }
                                }) {
                                    Text(textForIndex(index))
                                        .font(.headline)
                                        .foregroundColor(.black)
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

                        // Botão de som
                        Button(action: {
                            // Ação do botão de som
                        }) {
                            Image(systemName: "speaker.wave.2.fill")
                                .frame(width: 100, height: 50)
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
            }
            .navigationDestination(isPresented: $navigateToNextScreen) {
                TrilhaView()
            }
        }
    }
}

#Preview {
    L2Desafio5()
}
