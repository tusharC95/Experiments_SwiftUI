# Asia Country List

**AsiaCountryApp** is a SwiftUI-based iOS application that displays a list of Asian countries with key details such as capital and population. The user can tap on a country to select it and view more information through a pop-up alert.

## 📱 Features

- Displays a scrollable list of Asian countries.
- Tapping a country's name toggles a checkbox and shows:
  - Capital city
  - Population information
- Uses SwiftUI's `NavigationView`, `List`, `Alert`, and `@State` for UI and state management.
- Alert automatically deselects the country once dismissed.

## 🏗️ Architecture

- `Country` is a `struct` conforming to `Identifiable`, storing country name, capital, population, and selection state.
- `ContentView` manages the list and interaction logic using `@State`.
- The app’s entry point is `AsiaCountryApp`, using the SwiftUI `@main` declaration.

## 🔧 Technologies Used

- **Language:** Swift
- **Framework:** SwiftUI
- **Platform:** iOS

## 📋 Example Country Data

| Country          | Capital     | Population  |
|------------------|-------------|-------------|
| China            | Beijing     | 1.4 Billion |
| India            | New Delhi   | 1.39 Billion|
| Japan            | Tokyo       | 125 Million|
| South Korea      | Seoul       | 51 Million |
| Indonesia        | Jakarta     | 273 Million|
| Pakistan         | Islamabad   | 231 Million|
| Bangladesh       | Dhaka       | 169 Million|
| Vietnam          | Hanoi       | 98 Million |
| Thailand         | Bangkok     | 70 Million |

## 🚀 Getting Started

1. Open the project in **Xcode**.
2. Run the app on the **iOS Simulator** or a real device.
3. Tap on any country name to view its capital and population.
4. Tap "OK" to dismiss the alert and automatically uncheck the selection.

## 🧪 Preview

The `ContentView_Previews` struct provides a live preview of the user interface within Xcode.

![Preview-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/f864ac83-245f-4cbc-a569-adc8a7f9045b)


## 📄 License

This project is for educational and demonstration purposes. You are free to modify and distribute it as needed.
