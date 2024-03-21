import SwiftUI

struct DonationDetails {
    var restaurantName: String
    var donatedFoodAmount: Int
    var location: String
    var pickupDateTime: Date
}

@main
struct MindFlexApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var isPopoverPresented = false
    @State private var donationDetails: DonationDetails?
    @State private var restaurantName = ""
    @State private var donatedFoodAmountString = ""
    @State private var location = ""
    @State private var amount = ""
    @State private var pickupDateTime = Date()
    @State private var showThankYouPopup = false // New state variable for "Thank you for Donating" popup

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.isPopoverPresented.toggle()
                }) {
                    Text("Donate Food")
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(20)
                }
                .padding()
                .popover(isPresented: $isPopoverPresented) {
                    DonationDetailsPopover(
                        restaurantName: $restaurantName,
                        donatedFoodAmountString: $donatedFoodAmountString,
                        location: $location,
                        amount: $amount,
                        pickupDateTime: $pickupDateTime,
                        isPopoverPresented: $isPopoverPresented,
                        showThankYouPopup: $showThankYouPopup // Pass the binding to the Thank You popup
                    )
                }
            }
            Spacer()

            if let details = donationDetails {
                // Display collected details
                Text("Collected Donation Details:")
                Text("Restaurant Name: \(details.restaurantName)")
                Text("Donated Food Amount: \(details.donatedFoodAmount)")
                Text("Location: \(details.location)")
                Text("Pickup Date and Time: \(details.pickupDateTime)")
            }
        }
        .padding()
        .background(Color(red: 0.4627, green: 0.8392, blue: 1.0)) // Set background color to blue
        .sheet(isPresented: $showThankYouPopup, content: {
            ThankYouPopup() // Present the "Thank you for Donating" popup
        })
    }
}

struct DonationDetailsPopover: View {
    @Binding var restaurantName: String
    @Binding var donatedFoodAmountString: String
    @Binding var location: String
    @Binding var amount: String
    @Binding var pickupDateTime: Date
    @Binding var isPopoverPresented: Bool
    @Binding var showThankYouPopup: Bool // New binding for "Thank you for Donating" popup

    var body: some View {
        VStack {
            Text("Enter Donation Details")
                .font(.headline)
                .padding()

            TextField("Enter Restaurant Name", text: $restaurantName)
            TextField("Describe food", text: $donatedFoodAmountString)
                .keyboardType(.numberPad)
            TextField("Enter Amount of food (in pounds)", text: $amount)
            TextField("Enter Location", text: $location)

            DatePicker("Pickup Date and Time", selection: $pickupDateTime, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
                .padding()

            Button("Submit Donation") {
                // Call the method to collect donation details
                // For brevity, you can call the same method from ContentView
                // For example: ContentView().collectDonationDetails()

                // Dismiss the popover
                isPopoverPresented = false
                // Show the "Thank you for Donating" popup
                showThankYouPopup = true
            }
            .padding()
        }
        .padding()
        .background(Color(white: 0.9, opacity: 0.7)) // Set background color to lemonYellow
    }
}

struct ThankYouPopup: View {
    var body: some View {
        Color.green
            .edgesIgnoringSafeArea(.all) // Extend the color to fill the entire screen
            .overlay(
                VStack {
                    Text("Thank you for Donating!!!")
                        .font(.title)
                        .padding()
                    Text("Your generosity is appreciated!")
                        .padding()
                }
            )
        }
    }
