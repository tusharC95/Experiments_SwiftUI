# CheckoutViewApp

**CheckoutViewApp** is a SwiftUI-based iOS checkout interface that simulates the final stage of an e-commerce or food delivery order process. The app supports user interaction for delivery details, item review, discount code application, and navigation to the next step.

## 📱 Features

- Displays checkout summary including address, delivery time, and order items.
- Multiple delivery options: Priority, Standard, and Scheduled.
- Ability to apply a discount code via a modal popup.
- Real-time validation for 5-digit discount codes.
- Responsive layout with elegant SwiftUI design.

## 🧱 Architecture

- `CheckoutView` is the main view with various subcomponents:
  - Header
  - Address and note section
  - Delivery time and type
  - Order item summary
  - Discount code toggle and popup
  - Bottom CTA button
- State management uses SwiftUI's `@State` for UI interactivity and user input.

## 🛠️ Technologies Used

- **Language:** Swift
- **Framework:** SwiftUI
- **Platform:** iOS

## 🧪 Key Functional Elements

- Tap checkbox to toggle discount code modal.
- Validates discount codes to be 5 digits.
- User-friendly error messages for invalid inputs.
- Animated overlay for popup interaction.

## 🚀 Getting Started

1. Open the project in **Xcode**.
2. Build and run on the **iOS Simulator** or a real device.
3. Review your checkout details, apply a discount, and proceed with the order.

## 📱 Preview
<img src="https://github.com/user-attachments/assets/69981fe0-12e5-4299-89d9-ebc3618d6939" alt="CheckoutPage" style="width:50%; height:auto;">

## 📄 License

This app is built for demonstration and learning purposes. You are free to use and modify it as needed.

