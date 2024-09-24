//
//  L2Desafio1.swift
//  2EPO
//
//  Created by found on 10/09/24.
//
import SwiftUI

struct L2Desafio1: View {
    
    @State private var showingIncorrectSheet = false
    @State private var showingCorrectSheet = false
    @State private var selectedOption = ""
    @State private var navigateToNextScreen = false
    @State private var isCorrect = false
    @State private var respostacerta = "Do que 2 voando"
    private let voiceSynthesizer = VoiceSynthesizer()
    
    func textForIndex(_ index: Int) -> String {
        switch index {
        case 0:
            return "Do que 2 no ninho"
        case 1:
            return "Do que 2 voando"
        case 2:
            return "Do que 2 caindo"
        case 3:
            return "Do que 2 boiando"
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
                    
                    Text("Uma jovem pede a sua avó exemplos de ditados populares. Ela inicia o ditado “Mais vale um pássaro na mão”, convidando o jovem a completá-lo")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(height: 120)
                        .font(.system(size: 18))
                    
                    VStack {
                        Image("L2Desafio1")
                            .resizable()
                            .frame(width: 300, height: 200)
                        
                        Text("Complete o ditado!")
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        VStack(spacing: 0) {
                            ForEach(0..<4, id: \.self) { index in
                                Button(action: {
                                    selectedOption = textForIndex(index)
                                    if selectedOption == respostacerta {
                                        isCorrect = true
                                        showingCorrectSheet = true
                                    } else {
                                        isCorrect = false
                                        showingIncorrectSheet = true
                                    }
                                }) {
                                    Text(textForIndex(index))
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity)
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
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.botaoOpcao)
                                )
                        )
                        .padding(.bottom, 20)
                        
                        Button(action: {
                            voiceSynthesizer.speak("Mais vale um pássaro na mão, do que dois voando.")
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
                
                NavigationLink(destination: L2Desafio2(), isActive: $navigateToNextScreen) {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    L2Desafio1()
}
