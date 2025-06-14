import SwiftUI

struct MusicPlayerView: View {
    @State private var progress: Double = 0.28 // गाने की प्रगति (slider के लिए)
    @State private var isPlaying: Bool = true // गाना बज रहा है या रुका है
    @State private var showLyrics: Bool = false // बोल (Lyrics) पॉपअप दिखाना है या नहीं

    var body: some View {
        ZStack {
            // बैकग्राउंड ग्रेडिएंट (सुंदर रंगों का मिश्रण)
            LinearGradient(
                gradient: Gradient(colors: [Color.red.opacity(0.7), Color.black.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack {
                // प्लेलिस्ट का नाम
                Text("A-लिस्ट: पॉप")
                    .font(.headline)
                    .foregroundColor(.white)
                    .opacity(0.8)

                Text("३७ गाने")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .opacity(0.6)

                // एल्बम कवर (अगर इमेज नहीं है तो प्लेसहोल्डर दिखेगा)
                TabView {
                    ForEach(0..<3, id: \.self) { _ in
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 250, height: 250)
                                .shadow(radius: 10)

                            Image(systemName: "music.note.list") // प्लेसहोल्डर छवि
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding(.horizontal, 30)
                    }
                }
                .frame(height: 250)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                // गाने की जानकारी
                Text("एस & एम")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text("रिहाना - लाउड")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .opacity(0.8)

                // प्रगति पट्टी (Progress Bar)
                VStack {
                    Slider(value: $progress, in: 0...1)
                        .accentColor(.red)
                    
                    HStack {
                        Text(formatTime(seconds: progress * 228))
                            .font(.caption)
                            .foregroundColor(.white)
                            .opacity(0.6)
                        Spacer()
                        Text("३:४८")
                            .font(.caption)
                            .foregroundColor(.white)
                            .opacity(0.6)
                    }
                }
                .padding(.horizontal, 30)

                // प्लेबैक नियंत्रण (Playback Controls)
                HStack(spacing: 40) {
                    Button(action: {
                        // पिछला गाना
                    }) {
                        Image(systemName: "backward.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                    }

                    Button(action: {
                        isPlaying.toggle()
                    }) {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }

                    Button(action: {
                        // अगला गाना
                    }) {
                        Image(systemName: "forward.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 20)

                // बोल (Lyrics) देखने का विकल्प (CheckBox)
                HStack {
                    Spacer()
                    Toggle(isOn: $showLyrics) {
                        Text("गाने के बोल")
                            .foregroundColor(.white)
                            .font(.subheadline)
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .padding(.trailing, 20)
                }
            }
            .padding()
            
            // बोल (Lyrics) का पॉपअप
            if showLyrics {
                LyricsPopupView(showLyrics: $showLyrics)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut)
            }
        }
    }

    // समय को सही प्रारूप में दिखाने के लिए फंक्शन
    private func formatTime(seconds: Double) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

// गाने के बोल दिखाने वाला पॉपअप
struct LyricsPopupView: View {
    @Binding var showLyrics: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                HStack {
                    Text("गाने के बोल")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: { showLyrics = false }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                }
                .padding()

                ScrollView {
                    Text("""
                    ना-ना-ना, आओ चलो
                    ना-ना-ना, आओ चलो
                    ना-ना-ना, ना-ना, आओ चलो
                    ना-ना-ना, आओ चलो, चलो, चलो
                    """) // असली गाने के बोल यहाँ डालें
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.9))
            .cornerRadius(20)
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

// कस्टम चेकबॉक्स टॉगल स्टाइल
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .foregroundColor(configuration.isOn ? .red : .gray)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}

// प्रीव्यू
struct MusicPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MusicPlayerView()
    }
}

@main
struct MusicPlayerApp: App {
    var body: some Scene {
        WindowGroup {
            MusicPlayerView()
        }
    }
}
