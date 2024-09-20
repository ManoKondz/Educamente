//
//  FonologiaView.swift
//  2EPO
//
//  Created by found on 21/05/24.
//
import SwiftUI

struct Fonema: Identifiable {
    let id = UUID()
    let simbolo: String
    let som: String
}

struct FonologiaView: View {
    private let voiceSynthesizer = VoiceSynthesizer() // Criando uma instância da classe VoiceSynthesizer
    
    let fonemas = [
        Fonema(simbolo: "A", som: "a"),
        Fonema(simbolo: "Á", som: "á"),
        Fonema(simbolo: "Ã", som: "ã"),
        Fonema(simbolo: "AN", som: "an"),
        Fonema(simbolo: "AM", som: "am"),
        
        Fonema(simbolo: "B", som: "b"),
        Fonema(simbolo: "BA", som: "ba"),
        Fonema(simbolo: "BE", som: "be"),
        Fonema(simbolo: "BI", som: "bi"),
        Fonema(simbolo: "BO", som: "bo"),
        Fonema(simbolo: "BU", som: "bu"),
        
        Fonema(simbolo: "C", som: "k"),
        Fonema(simbolo: "CA", som: "ca"),
        Fonema(simbolo: "CO", som: "co"),
        Fonema(simbolo: "CU", som: "cu"),
        Fonema(simbolo: "C", som: "s"),
        Fonema(simbolo: "CE", som: "ce"),
        Fonema(simbolo: "CI", som: "ci"),
        
        Fonema(simbolo: "D", som: "d"),
        Fonema(simbolo: "DA", som: "da"),
        Fonema(simbolo: "DE", som: "de"),
        Fonema(simbolo: "DI", som: "di"),
        Fonema(simbolo: "DO", som: "do"),
        Fonema(simbolo: "DU", som: "du"),
        
        Fonema(simbolo: "E", som: "e"),
        Fonema(simbolo: "É", som: "é"),
        Fonema(simbolo: "EN", som: "en"),
        Fonema(simbolo: "EM", som: "em"),
        
        Fonema(simbolo: "F", som: "f"),
        Fonema(simbolo: "FA", som: "fa"),
        Fonema(simbolo: "FE", som: "fe"),
        Fonema(simbolo: "FI", som: "fi"),
        Fonema(simbolo: "FO", som: "fo"),
        Fonema(simbolo: "FU", som: "fu"),
        
        Fonema(simbolo: "G", som: "g"),
        Fonema(simbolo: "GA", som: "ga"),
        Fonema(simbolo: "GO", som: "go"),
        Fonema(simbolo: "GU", som: "gu"),
        Fonema(simbolo: "G", som: "ʒ"),
        Fonema(simbolo: "GE", som: "ge"),
        Fonema(simbolo: "GI", som: "gi"),
        
        Fonema(simbolo: "H", som: "h"), // O "H" é mudo, então não forma sílabas diretamente
        
        Fonema(simbolo: "I", som: "i"),
        Fonema(simbolo: "Í", som: "í"),
        Fonema(simbolo: "IN", som: "in"),
        Fonema(simbolo: "IM", som: "im"),
        
        Fonema(simbolo: "J", som: "ʒ"),
        Fonema(simbolo: "JA", som: "ja"),
        Fonema(simbolo: "JE", som: "je"),
        Fonema(simbolo: "JI", som: "ji"),
        Fonema(simbolo: "JO", som: "jo"),
        Fonema(simbolo: "JU", som: "ju"),
        
        Fonema(simbolo: "K", som: "k"),
        Fonema(simbolo: "KA", som: "ka"),
        Fonema(simbolo: "KE", som: "ke"),
        Fonema(simbolo: "KI", som: "ki"),
        Fonema(simbolo: "KO", som: "ko"),
        Fonema(simbolo: "KU", som: "ku"),
        
        Fonema(simbolo: "L", som: "l"),
        Fonema(simbolo: "LA", som: "la"),
        Fonema(simbolo: "LE", som: "le"),
        Fonema(simbolo: "LI", som: "li"),
        Fonema(simbolo: "LO", som: "lo"),
        Fonema(simbolo: "LU", som: "lu"),
        
        Fonema(simbolo: "M", som: "m"),
        Fonema(simbolo: "MA", som: "ma"),
        Fonema(simbolo: "ME", som: "me"),
        Fonema(simbolo: "MI", som: "mi"),
        Fonema(simbolo: "MO", som: "mo"),
        Fonema(simbolo: "MU", som: "mu"),
        
        Fonema(simbolo: "N", som: "n"),
        Fonema(simbolo: "NA", som: "na"),
        Fonema(simbolo: "NE", som: "ne"),
        Fonema(simbolo: "NI", som: "ni"),
        Fonema(simbolo: "NO", som: "nô"),
        Fonema(simbolo: "NU", som: "nu"),
        
        Fonema(simbolo: "O", som: "o"),
        Fonema(simbolo: "Ó", som: "ó"),
        Fonema(simbolo: "ON", som: "on"),
        Fonema(simbolo: "OM", som: "om"),
        
        Fonema(simbolo: "P", som: "p"),
        Fonema(simbolo: "PA", som: "pa"),
        Fonema(simbolo: "PE", som: "pe"),
        Fonema(simbolo: "PI", som: "pi"),
        Fonema(simbolo: "PO", som: "po"),
        Fonema(simbolo: "PU", som: "pu"),
        
        Fonema(simbolo: "Q", som: "k"),
        Fonema(simbolo: "QUE", som: "que"),
        Fonema(simbolo: "QUI", som: "qui"),
        
        Fonema(simbolo: "R", som: "ʁ"),
        Fonema(simbolo: "RA", som: "ra"),
        Fonema(simbolo: "RE", som: "re"),
        Fonema(simbolo: "RI", som: "ri"),
        Fonema(simbolo: "RO", som: "ro"),
        Fonema(simbolo: "RU", som: "ru"),
        
        Fonema(simbolo: "S", som: "s"),
        Fonema(simbolo: "SA", som: "sa"),
        Fonema(simbolo: "SE", som: "se"),
        Fonema(simbolo: "SI", som: "si"),
        Fonema(simbolo: "SO", som: "so"),
        Fonema(simbolo: "SU", som: "su"),
        
        Fonema(simbolo: "T", som: "t"),
        Fonema(simbolo: "TA", som: "ta"),
        Fonema(simbolo: "TE", som: "te"),
        Fonema(simbolo: "TI", som: "ti"),
        Fonema(simbolo: "TO", som: "to"),
        Fonema(simbolo: "TU", som: "tu"),
        
        Fonema(simbolo: "U", som: "u"),
        Fonema(simbolo: "Ú", som: "ú"),
        Fonema(simbolo: "UN", som: "un"),
        Fonema(simbolo: "UM", som: "um"),
        
        Fonema(simbolo: "V", som: "v"),
        Fonema(simbolo: "VA", som: "va"),
        Fonema(simbolo: "VE", som: "ve"),
        Fonema(simbolo: "VI", som: "vi"),
        Fonema(simbolo: "VO", som: "vo"),
        Fonema(simbolo: "VU", som: "vu"),
        
        Fonema(simbolo: "W", som: "w"),
        Fonema(simbolo: "WA", som: "wa"),
        Fonema(simbolo: "WE", som: "we"),
        Fonema(simbolo: "WI", som: "wi"),
        Fonema(simbolo: "WO", som: "wo"),
        Fonema(simbolo: "WU", som: "wu"),
        
        Fonema(simbolo: "X", som: "ʃ"),
        Fonema(simbolo: "XA", som: "xa"),
        Fonema(simbolo: "XE", som: "xe"),
        Fonema(simbolo: "XI", som: "xi"),
        Fonema(simbolo: "XO", som: "xo"),
        Fonema(simbolo: "XU", som: "xu"),
        
        Fonema(simbolo: "Y", som: "i"),
        Fonema(simbolo: "YA", som: "ya"),
        Fonema(simbolo: "YE", som: "ye"),
        Fonema(simbolo: "YI", som: "yi"),
        Fonema(simbolo: "YO", som: "yo"),
        Fonema(simbolo: "YU", som: "yu"),
        
        Fonema(simbolo: "Z", som: "z"),
        Fonema(simbolo: "ZA", som: "za"),
        Fonema(simbolo: "ZE", som: "ze"),
        Fonema(simbolo: "ZI", som: "zi"),
        Fonema(simbolo: "ZO", som: "zo"),
        Fonema(simbolo: "ZU", som: "zu"),
    ]
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Clique em um fonema para ouvir o som")
                    .font(.title)
                    .padding(.top, 20)
                    .foregroundColor(.white)
                    
                
                // Exibição dos fonemas em linhas
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 20) {
                        ForEach(fonemas) { fonema in
                            Button(action: {
                                voiceSynthesizer.speak(fonema.som) // Toca o som do fonema
                            }) {
                                Text(fonema.simbolo)
                                    .font(.largeTitle)
                                    .frame(width: 80, height: 80)
                                    .background(Color.botaoOpcao)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.top, 30)
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .background(Color.background)
        }
    }
}

#Preview {
    FonologiaView()
}

