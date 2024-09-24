import SwiftUI
import AVFoundation

struct L1Desafio1: View {
    
    @State private var showingIncorrectSheet = false
    @State private var showingCorrectSheet = false
    @State private var isCorrect = false
    @State private var navigateToNextScreen = false
    
    private let voiceSynthesizer = VoiceSynthesizer() // Instância da classe VoiceSynthesizer
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.menu
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.barcolor)
                            .frame(height: 25)
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.progressBar)
                            .frame(width: 72, height: 25)
                    }
                    .padding(.horizontal)
                    
                    Text("Dois grupos estão discutindo qual a forma correta de escrever a palavra \"mão\" no plural")
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                    
                    Image("L1Desafio1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 200)
                        .padding()
                        .cornerRadius(200)
                        .foregroundColor(.black)
                    
                    Text("Declare apoio ao grupo correto")
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .padding()
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            isCorrect = true
                            showingCorrectSheet = true
                        }) {
                            VStack {
                                Image(systemName: "person.3.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 110)
                                Text("Mãos")
                                    .font(.headline)
                                    .padding(.bottom, 10)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.botaoOpcao)
                            .cornerRadius(20)
                            .foregroundColor(.black)
                            .shadow(radius: 5)
                        }
                        
                        Button(action: {
                            isCorrect = false
                            showingIncorrectSheet = true
                        }) {
                            VStack {
                                Image(systemName: "person.3.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 110)
                                Text("Mões")
                                    .font(.headline)
                                    .padding(.bottom, 10)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.botaoOpcao)
                            .cornerRadius(20)
                            .foregroundColor(.black)
                            .shadow(radius: 5)
                        }
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        voiceSynthesizer.speak("Dois grupos estão discutindo qual a forma correta de escrever a palavra mão no plural.")
                        voiceSynthesizer.speak("Declare apoio ao grupo correto.")
                    }) {
                        Image(systemName: "speaker.3.fill")
                            .frame(width: 100)
                            .padding()
                            .background(Color.botaoPadrao)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 20)
                }
                .padding()
            }
            .sheet(isPresented: $showingCorrectSheet) {
                CustomSheetViewTrue(onDismiss: {
                    showingCorrectSheet = false
                    navigateToNextScreen = true
                })
                .presentationDetents([.fraction(0.25)]) // Ajuste correto da altura do sheet
            }
            .sheet(isPresented: $showingIncorrectSheet) {
                CustomSheetViewFalse(onDismiss: {
                    showingIncorrectSheet = false
                    navigateToNextScreen = true
                })
                .presentationDetents([.fraction(0.25)]) // Ajuste correto da altura do sheet
            }
            
            // Navegação para a próxima tela
            NavigationLink(destination: L1Desafio2(), isActive: $navigateToNextScreen) {
                EmptyView()
            }
        }
    }
}

#Preview {
    L1Desafio1()
}

