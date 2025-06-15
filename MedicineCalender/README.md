# MedicineCalenderApp

**MedicineCalenderApp** is a SwiftUI-based application designed to help users track their daily medicine intake using a calendar interface. It combines neumorphic UI design with user-friendly prompts to ensure users can easily mark their medicine status for each day.

## 💊 Features

- Interactive calendar displaying each day of the current month.
- Tap on any past or current date to record whether medicine was taken.
- Uses color indicators for:
  - ✅ Green: Medicine taken
  - ❌ Red: Medicine missed
  - 🟠 Orange: Today
- Neumorphic style buttons and popups.
- Persistent storage using `UserDefaults`.
- View complete medicine intake history in a separate screen.

## 🧱 Architecture

- `MedicineCalender`: Main view containing the calendar and interaction logic.
- `CalendarDayView`: Individual day cell with dynamic background.
- `CalendarHeaderView`: Displays current month and year.
- `MedicineRecordsView`: Lists all saved medicine records.
- Custom neumorphic style via a `View` extension.

## 🔧 Technologies Used

- **Language:** Swift
- **Framework:** SwiftUI
- **Storage:** UserDefaults

## 📱 Preview
<img src="https://github.com/user-attachments/assets/a14ed26a-db3e-4159-847e-fb3256d0f6d7" alt="MedicineCalender" style="height:50%; height:auto;">

## 🚀 Getting Started

1. Open the project in **Xcode**.
2. Run on the **iOS Simulator** or a real device.
3. Tap on any valid day to mark "Yes" or "No" for medicine.

4. View the entire medicine intake history by tapping **Records**.

## 📅 Visual Indicators

| Symbol | Meaning            |
|--------|--------------------|
| 🟢     | Medicine taken      |
| 🔴     | Medicine not taken  |
| 🟠     | Today               |
| ⚪️     | No record           |

## 📄 License

This app is created for educational and demonstration purposes. Free to use, modify, and extend.

