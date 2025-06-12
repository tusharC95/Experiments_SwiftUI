# BowlingApp

**BowlingApp** is a SwiftUI-based iOS application that showcases bowling performances of players. The app enables users to view and compare performances based on wickets taken and economy rate.

## 📱 Features

- View a list of bowling performances with detailed statistics.
- Tap checkboxes to select and view individual performance details.
- Toggle between:
  - **Top 3 Performances by Wickets**
  - **Top 3 Performances by Economy**
- Clean and responsive SwiftUI layout.

## 🏗️ Architecture

- `BowlingPerformance` struct represents each player's performance and conforms to `Identifiable`.
- `ContentView` handles state management, UI logic, and rendering.
- `BowlingApp` is the app's main entry point using `@main`.

## 🔧 Technologies Used

- **Language:** Swift
- **Framework:** SwiftUI
- **Platform:** iOS

## 📊 Sample Data Fields

Each bowling performance includes:
- Player name
- Overs bowled
- Maiden overs
- Runs conceded
- Wickets taken
- Economy rate
- Opposition team
- Match ground
- Match date

## 🚀 Getting Started

1. Open the project in **Xcode**.
2. Build and run on the **iOS Simulator** or a real device.
3. Tap on any player's checkbox to view full performance details.
4. Use the checkboxes at the top to display top 3 wicket-takers and economy performers.

## 📱 Preview
![PreviewBowling](https://github.com/user-attachments/assets/c63c39d2-23df-4aa4-a05b-e2ff8dd302b6)


## 📄 License

This project is for educational and demo purposes. Free to use and modify.

