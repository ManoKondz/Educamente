import SwiftUI

struct CustomSheetViewTrue: View {
    var onDismiss: () -> Void
    private let voiceSynthesizer = VoiceSynthesizer()
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                
                VStack(alignment: .leading) {
                    Text("Excelente! Parabéns!")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                
                Spacer()
                
                Button(action: {
                    voiceSynthesizer.speak("Excelente! Parabéns!")
                }) {
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
                onDismiss()
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
    }
}

struct CustomSheetViewFalse: View {
    var onDismiss: () -> Void
    private let voiceSynthesizer = VoiceSynthesizer()
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                
                VStack(alignment: .leading) {
                    Text("Ops... Na próxima dá certo")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                
                Spacer()
                
                Button(action: {
                    voiceSynthesizer.speak("Ops... Na próxima dá certo")
                }) {
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
                onDismiss()
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
    }
}
