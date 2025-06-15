import SwiftUI

// MARK: - Neumorphic Modifier
extension View {
    func neumorphicStyle(
        cornerRadius: CGFloat = 10,
        color: Color = Color(red: 224/255, green: 224/255, blue: 224/255)
    ) -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(color)
                    .shadow(color: .white.opacity(0.8), radius: 5, x: -5, y: -5)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5)
            )
    }
}

// MARK: - Main Calendar View
struct MedicineCalender: View {
    @State private var currentMonth: Date = Date()
    @State private var selectedDate: Date?
    @State private var showPopup = false
    @State private var medicineRecords: [String: Bool] = UserDefaults.standard.dictionary(forKey: "medicineRecords") as? [String: Bool] ?? [:]
    @State private var showRecords = false
    @State private var selectedAnswer: Bool? = nil

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        VStack(spacing: 0) {
            CalendarHeaderView(date: currentMonth)

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(getDaysInMonth(), id: \.self) { day in
                    CalendarDayView(date: day, onTap: {
                        if !isFutureDate(day) {
                            selectedDate = day
                            selectedAnswer = medicineRecords[formattedDate(day)]
                            showPopup = true
                        }
                    }, medicineTaken: medicineRecords[formattedDate(day)], isFuture: isFutureDate(day))
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)

            Spacer()

            Button("Records") {
                showRecords = true
            }
            .padding()
            .neumorphicStyle()
            .padding(.bottom, 10)
        }
        .padding(.top)
        .background(Color(red: 224/255, green: 224/255, blue: 224/255))
        .ignoresSafeArea(edges: [.bottom]) // To not overlap with home indicator
        .sheet(isPresented: $showRecords) {
            MedicineRecordsView(records: medicineRecords)
        }
        .overlay(
            popupView().opacity(showPopup ? 1 : 0)
        )
    }

    private func getDaysInMonth() -> [Date] {
        let calendar = Calendar.current
        guard let range = calendar.range(of: .day, in: .month, for: currentMonth),
              let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth)) else {
            return []
        }
        return range.compactMap { calendar.date(byAdding: .day, value: $0 - 1, to: firstDay) }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    private func isFutureDate(_ date: Date) -> Bool {
        return date > Date()
    }

    @ViewBuilder
    private func popupView() -> some View {
        if let selectedDate = selectedDate {
            ZStack {
                Color.black.opacity(0.3).ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("Have you taken medicine today?")
                        .font(.headline)
                        .padding(.top, 10)

                    HStack(spacing: 20) {
                        Button(action: { selectedAnswer = true }) {
                            HStack {
                                Image(systemName: selectedAnswer == true ? "checkmark.square.fill" : "square")
                                    .foregroundColor(.green)
                                Text("Yes")
                            }
                            .padding()
                            .frame(width: 100)
                            .neumorphicStyle()
                        }

                        Button(action: { selectedAnswer = false }) {
                            HStack {
                                Image(systemName: selectedAnswer == false ? "checkmark.square.fill" : "square")
                                    .foregroundColor(.red)
                                Text("No")
                            }
                            .padding()
                            .frame(width: 100)
                            .neumorphicStyle()
                        }
                    }

                    HStack(spacing: 16) {
                        Button("Save") {
                            if let answer = selectedAnswer {
                                saveMedicineRecord(for: selectedDate, taken: answer)
                            }
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .neumorphicStyle()

                        Button("Close") {
                            showPopup = false
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .neumorphicStyle()
                    }
                }
                .padding()
                .frame(width: 320)
                .background(Color(red: 224/255, green: 224/255, blue: 224/255))
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
                .shadow(color: .white.opacity(0.7), radius: 10, x: -5, y: -5)
            }
        }
    }

    private func saveMedicineRecord(for date: Date, taken: Bool) {
        let key = formattedDate(date)
        medicineRecords[key] = taken
        UserDefaults.standard.set(medicineRecords, forKey: "medicineRecords")
        showPopup = false
    }
}

// MARK: - Calendar Header
struct CalendarHeaderView: View {
    let date: Date
    private let formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMMM yyyy"
        return df
    }()

    var body: some View {
        Text(formatter.string(from: date))
            .font(.title)
            .fontWeight(.bold)
            .padding(.vertical, 10)
    }
}

// MARK: - Calendar Day Cell
struct CalendarDayView: View {
    let date: Date
    let onTap: () -> Void
    let medicineTaken: Bool?
    let isFuture: Bool

    private let calendar = Calendar.current

    var body: some View {
        Text("\(calendar.component(.day, from: date))")
            .font(.headline)
            .frame(width: 40, height: 40)
            .background(
                ZStack {
                    if isToday {
                        Circle().fill(Color.orange.opacity(0.8))
                    } else if medicineTaken == true {
                        Circle().fill(Color.green.opacity(0.8))
                    } else if medicineTaken == false {
                        Circle().fill(Color.red.opacity(0.8))
                    } else {
                        Circle()
                            .fill(Color(red: 224/255, green: 224/255, blue: 224/255))
                            .shadow(color: .white.opacity(0.8), radius: 2, x: -2, y: -2)
                            .shadow(color: .black.opacity(0.2), radius: 2, x: 2, y: 2)
                    }
                }
            )
            .clipShape(Circle())
            .foregroundColor(isFuture ? .gray : (isToday ? .white : .primary))
            .opacity(isFuture ? 0.4 : 1.0)
            .onTapGesture {
                if !isFuture {
                    onTap()
                }
            }
    }

    private var isToday: Bool {
        calendar.isDateInToday(date)
    }
}

// MARK: - Record List View
struct MedicineRecordsView: View {
    let records: [String: Bool]

    var body: some View {
        NavigationView {
            List(records.sorted(by: { $0.key > $1.key }), id: \.key) { date, taken in
                HStack {
                    Text(date)
                    Spacer()
                    Text(taken ? "Yes" : "No")
                        .foregroundColor(taken ? .green : .red)
                }
            }
            .navigationTitle("Medicine Records")
        }
    }
}

// MARK: - App Entry
@main
struct MedicineCalenderApp: App {
    var body: some Scene {
        WindowGroup {
            MedicineCalender()
        }
    }
}

struct SimpleCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineCalender()
    }
}
