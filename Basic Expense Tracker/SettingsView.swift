//
//  SettingsView.swift
//  Basic Expense Tracker
//
//  Created by Nguyen Nha on 6/18/26.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    // Use @AppStorage to persist the selected currency across app launches
    @AppStorage("currency_preference")
    private var selectedCurrency = "USD"
    
    // Use @Environment to access the dismiss function, which allows us to close the view when the user is done editing
    @Environment(\.dismiss)
        private var dismiss
    
    @Binding var expenses: [Expense]

    @State private var showDeleteAlert = false
    
    // The body of the view, which contains a list of settings options for the user to customize their preferences and view app information
    var body: some View {

        NavigationStack {

            List {

                // Section for user preferences, which includes a navigation link to the currency settings view where the user can select their preferred currency for displaying expenses
                Section("Preferences") {

                    NavigationLink {

                        CurrencySettingsView()

                    } label: {

                        HStack {

                            Label(
                                "Currency",
                                systemImage: "dollarsign.circle"
                            )

                            Spacer()

                            Text(selectedCurrency)
                                .foregroundColor(.secondary)

                        }

                    }

                }
                
                Section("Reset") {

                    Button(role: .destructive) {
                        showDeleteAlert = true
                    } label: {
                        Label(
                            "Clear All Expenses",
                            systemImage: "trash"
                        )
                    }

                }.alert(
                    "Delete All Expenses?",
                    isPresented: $showDeleteAlert
                ) {

                    Button("Cancel", role: .cancel) { }

                    Button("Delete All", role: .destructive) {

                        expenses.removeAll()

                    }

                } message: {

                    Text(
                        "This action cannot be undone."
                    )

                }
                
                // Section for app information, which displays the current version of the app to the user
                Section("About") {

                    HStack {

                        Text("Version")

                        Spacer()

                        Text("0.6")
                            .foregroundColor(.secondary)

                    }

                }

            }
            .navigationTitle("Settings")
            .toolbar {

                ToolbarItem(
                    placement: .navigationBarTrailing
                ) {

                    Button("Done") {

                        dismiss()

                    }

                }

            }

        }

    }

}

// Preview provider for SwiftUI previews, which allows us to see a preview of the SettingsView in Xcode's canvas
struct SettingsView_Previews: PreviewProvider {

    static var previews: some View {

        SettingsView(
            expenses: .constant([])
        )

    }

}
