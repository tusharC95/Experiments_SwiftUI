import SwiftUI

// गेंदबाजी प्रदर्शन को दर्शाने वाला संरचना
struct BowlingPerformance: Identifiable {
    let id = UUID()
    let player: String
    let overs: Double
    let maidens: Int
    let runs: Int
    let wickets: Int
    let economy: Double
    let opposition: String
    let ground: String
    let matchDate: String
}

struct ContentView: View {
    @State private var selectedBowlers: Set<UUID> = [] // चयनित गेंदबाजों की सूची
    @State private var showTopWickets = false // शीर्ष विकेट प्रदर्शन दिखाने के लिए
    @State private var showTopEconomy = false // शीर्ष इकॉनमी प्रदर्शन दिखाने के लिए
    
    // गेंदबाजी प्रदर्शन का डेटा
    let performances = [
        BowlingPerformance(player: "SN Netravalkar", overs: 4.0, maidens: 1, runs: 12, wickets: 5, economy: 3.00, opposition: "Singapore", ground: "Bulawayo", matchDate: "12 Jul 2022"),
        BowlingPerformance(player: "Milind Kumar", overs: 4.0, maidens: 0, runs: 16, wickets: 5, economy: 4.00, opposition: "Namibia", ground: "Windhoek", matchDate: "05 Oct 2024"),
        BowlingPerformance(player: "NK Patel", overs: 4.0, maidens: 0, runs: 17, wickets: 4, economy: 4.25, opposition: "Bahamas", ground: "Coolidge", matchDate: "13 Nov 2021"),
        BowlingPerformance(player: "Harmeet Singh", overs: 4.0, maidens: 0, runs: 18, wickets: 4, economy: 4.50, opposition: "Canada", ground: "Prairie View", matchDate: "12 Apr 2024"),
        BowlingPerformance(player: "TK Patel", overs: 4.0, maidens: 0, runs: 27, wickets: 4, economy: 6.75, opposition: "Canada", ground: "Sandys Parish", matchDate: "21 Aug 2019"),
        BowlingPerformance(player: "K Gore", overs: 4.0, maidens: 2, runs: 5, wickets: 3, economy: 1.25, opposition: "Bermuda", ground: "Sandys Parish", matchDate: "22 Aug 2019"),
        BowlingPerformance(player: "Harmeet Singh", overs: 4.0, maidens: 0, runs: 8, wickets: 3, economy: 2.00, opposition: "Netherlands", ground: "The Hague", matchDate: "28 Aug 2024"),
        BowlingPerformance(player: "J Theron", overs: 4.0, maidens: 0, runs: 16, wickets: 3, economy: 4.00, opposition: "Belize", ground: "Coolidge", matchDate: "07 Nov 2021"),
        BowlingPerformance(player: "K Gore", overs: 4.0, maidens: 0, runs: 21, wickets: 3, economy: 5.25, opposition: "Canada", ground: "Sandys Parish", matchDate: "25 Aug 2019"),
        BowlingPerformance(player: "NP Kenjige", overs: 4.0, maidens: 0, runs: 21, wickets: 3, economy: 5.25, opposition: "Canada", ground: "Prairie View", matchDate: "07 Apr 2024"),
    ]
    
    // शीर्ष 3 प्रदर्शन विकेट के आधार पर
    var topWickets: [BowlingPerformance] {
        performances.sorted { $0.wickets > $1.wickets || ($0.wickets == $1.wickets && $0.economy < $1.economy) }.prefix(3).map { $0 }
    }
    
    // शीर्ष 3 प्रदर्शन इकॉनमी के आधार पर
    var topEconomy: [BowlingPerformance] {
        performances.sorted { $0.economy < $1.economy }.prefix(3).map { $0 }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // शीर्ष 3 विकेट और इकॉनमी प्रदर्शन दिखाने के लिए चेकबॉक्स
                HStack {
                    HStack {
                        Image(systemName: showTopWickets ? "checkmark.square.fill" : "square")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                showTopWickets.toggle()
                            }
                        Text("Top 3 Wickets")
                    }
                    .padding()
                    
                    HStack {
                        Image(systemName: showTopEconomy ? "checkmark.square.fill" : "square")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                showTopEconomy.toggle()
                            }
                        Text("Top 3 Economy")
                    }
                    .padding()
                }
                
                // गेंदबाजों की सूची
                List {
                    ForEach(performances) { performance in
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: selectedBowlers.contains(performance.id) ? "checkmark.square.fill" : "square")
                                    .foregroundColor(.blue)
                                    .onTapGesture {
                                        if selectedBowlers.contains(performance.id) {
                                            selectedBowlers.remove(performance.id)
                                        } else {
                                            selectedBowlers.insert(performance.id)
                                        }
                                    }
                                
                                Text(performance.player)
                                    .font(.headline)
                            }
                            
                            // यदि गेंदबाज चयनित है तो उसका प्रदर्शन दिखाएं
                            if selectedBowlers.contains(performance.id) {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Overs: \(performance.overs)")
                                    Text("Maidens: \(performance.maidens)")
                                    Text("Runs: \(performance.runs)")
                                    Text("Wickets: \(performance.wickets)")
                                    Text("Economy: \(String(format: "%.2f", performance.economy))")
                                    Text("Opposition: \(performance.opposition)")
                                    Text("Ground: \(performance.ground)")
                                    Text("Match Date: \(performance.matchDate)")
                                }
                                .padding(.leading, 20)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
                
                // शीर्ष 3 प्रदर्शन विकेट के आधार पर दिखाएं
                if showTopWickets {
                    VStack(alignment: .leading) {
                        Text("Top 3 Performances by Wickets:")
                            .font(.headline)
                        ForEach(topWickets) { performance in
                            Text("\(performance.player): \(performance.wickets) wickets, Econ \(performance.economy)")
                        }
                    }
                    .padding()
                }
                
                // शीर्ष 3 प्रदर्शन इकॉनमी के आधार पर दिखाएं
                if showTopEconomy {
                    VStack(alignment: .leading) {
                        Text("Top 3 Performances by Economy:")
                            .font(.headline)
                        ForEach(topEconomy) { performance in
                            Text("\(performance.player): Econ \(performance.economy), Wickets \(performance.wickets)")
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Bowling Performances")
        }
    }
}

@main
struct BowlingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#Preview {
    ContentView() // पूर्वावलोकन के लिए मुख्य दृश्य दिखाता है
}

