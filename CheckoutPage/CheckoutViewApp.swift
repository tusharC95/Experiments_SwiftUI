import SwiftUI

struct CheckoutView: View {
    // छूट लागू करने के लिए स्थिति प्रबंधन
    @State private var applyDiscount = false
    @State private var showDiscountPopup = false
    @State private var discountCode = ""
    @State private var enteredCode = ""
    @State private var errorMessage: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // हेडर अनुभाग
            HStack {
                Text("Checkout")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Button(action: { }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
            }
            
            // पता और डिलीवरी नोट
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(.black)
                    VStack(alignment: .leading) {
                        Text("Dundas St E")
                            .fontWeight(.bold)
                        Text("Toronto, Toronto")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.black)
                    VStack(alignment: .leading) {
                        Text("Meet at door")
                            .fontWeight(.bold)
                        Text("Add delivery note")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                    Spacer()
                }
            }
            
            // डिलीवरी समय
            HStack {
                Text("Delivery Time")
                    .font(.headline)
                Spacer()
                Text("10–20 min")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            // डिलीवरी विकल्प
            VStack(spacing: 8) {
                Button(action: {}) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Priority")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            Text("Delivered directly to you")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("+$1.99")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                
                Button(action: {}) {
                    Text("Standard")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                
                Button(action: {}) {
                    Text("Schedule")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
            }
            
            // ऑर्डर आइटम्स
            Text("Your items")
                .font(.headline)
            
            HStack {
                Text("1")
                Text("Regular Oreo McFlurry")
                    .fontWeight(.bold)
                Spacer()
                Text("$5.69")
            }
            
            // डिस्काउंट लागू करने का विकल्प
            HStack {
                Button(action: {
                    applyDiscount.toggle()
                    if applyDiscount {
                        showDiscountPopup = true
                    }
                }) {
                    Image(systemName: applyDiscount ? "checkmark.square.fill" : "square")
                        .foregroundColor(.black)
                }
                Text(discountCode.isEmpty ? "Apply Discount" : "Discount Applied")
                    .font(.headline)
            }
            .padding(.top, 10)
            
            if !discountCode.isEmpty {
                Text("Discount Code: \(discountCode)")
                    .foregroundColor(.green)
                    .font(.subheadline)
            }
            
            Spacer()
            
            // अगला बटन
            Button(action: {}) {
                Text("Next : $5.89")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }
        }
        .padding()
        
        // पॉपअप विंडो
        .overlay(
            Group {
                if showDiscountPopup {
                    ZStack {
                        Color.black.opacity(0.3)
                            .ignoresSafeArea()

                        VStack(spacing: 20) {
                            Text("Enter Discount Code")
                                .font(.headline)
                                .multilineTextAlignment(.center)

                            TextField("5-digit code", text: $enteredCode)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(10)
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                )
                                .frame(width: 220)
                                .keyboardType(.numberPad)
                                .onChange(of: enteredCode) {
                                    if enteredCode.count > 5 {
                                        enteredCode = String(enteredCode.prefix(5))
                                    }
                                }

                            if let errorMessage = errorMessage {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }

                            HStack(spacing: 16) {
                                Button(action: {
                                    showDiscountPopup = false
                                    enteredCode = ""
                                    errorMessage = nil
                                }) {
                                    Text("Cancel")
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 44)
                                        .background(Color.black)
                                        .cornerRadius(10)
                                }

                                Button(action: {
                                    if enteredCode.count == 5 {
                                        discountCode = enteredCode
                                        showDiscountPopup = false
                                        errorMessage = nil
                                    } else {
                                        errorMessage = "Please enter a valid 5-digit code."
                                    }
                                }) {
                                    Text("Apply")
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 44)
                                        .background(Color.black)
                                        .cornerRadius(10)
                                }
                            }
                            .frame(width: 220) // Ensure side-by-side buttons align
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 8)
                    }
                }
            }
        )
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}

@main
struct CheckoutViewApp: App {
    var body: some Scene {
        WindowGroup {
            CheckoutView() // ऐप का मुख्य प्रवेश बिंदु
        }
    }
}


