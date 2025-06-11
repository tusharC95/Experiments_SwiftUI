import SwiftUI

// देश की जानकारी के लिए डेटा मॉडल
struct Country: Identifiable {
    let id = UUID()
    let name: String // देश का नाम
    let capital: String // राजधानी
    let population: String // जनसंख्या
    var isSelected: Bool = false // चयनित स्थिति
}

struct ContentView: View {
    @State private var countries = [
        Country(name: "चीन", capital: "बीजिंग", population: "1.4 अरब"),
        Country(name: "भारत", capital: "नई दिल्ली", population: "1.39 अरब"),
        Country(name: "जापान", capital: "टोक्यो", population: "12.5 करोड़"),
        Country(name: "दक्षिण कोरिया", capital: "सियोल", population: "5.1 करोड़"),
        Country(name: "इंडोनेशिया", capital: "जकार्ता", population: "27.3 करोड़"),
        Country(name: "पाकिस्तान", capital: "इस्लामाबाद", population: "23.1 करोड़"),
        Country(name: "बांग्लादेश", capital: "ढाका", population: "16.9 करोड़"),
        Country(name: "वियतनाम", capital: "हनोई", population: "9.8 करोड़"),
        Country(name: "थाईलैंड", capital: "बैंकॉक", population: "7 करोड़")
    ]
    
    @State private var selectedCountry: Country? // चयनित देश को संग्रहीत करने के लिए
    
    var body: some View {
        NavigationView {
            List {
                // प्रत्येक देश को सूची में दिखाने के लिए
                ForEach($countries) { $country in
                    HStack {
                        // चयन बॉक्स दिखाना
                        Image(systemName: country.isSelected ? "checkmark.square.fill" : "square")
                            .foregroundColor(country.isSelected ? .blue : .gray)
                        
                        // देश के नाम पर टैप करने से चयन बदल जाएगा
                        Text(country.name)
                            .onTapGesture {
                                country.isSelected.toggle()
                                selectedCountry = country
                            }
                        Spacer()
                    }
                }
            }
            .navigationTitle("एशियाई देश") // शीर्षक सेट करना
            .alert(item: $selectedCountry) { country in
                Alert(
                    title: Text(country.name), // देश का नाम शीर्षक में
                    message: Text("राजधानी: \(country.capital)\nदेश की कुल जनसंख्या: \(country.population)"), // राजधानी और जनसंख्या दिखाना
                    dismissButton: .default(Text("ठीक है")) {
                        // अलर्ट बंद करने पर चयन हटाना
                        if let index = countries.firstIndex(where: { $0.id == country.id }) {
                            countries[index].isSelected = false
                        }
                        selectedCountry = nil
                    }
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// मुख्य ऐप का प्रवेश बिंदु
@main
struct AsiaCountryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
