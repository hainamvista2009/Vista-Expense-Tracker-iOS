//
//  SettingsView.swift
//  Basic Expense Tracker
//
//  Created by Nguyen Nha on 6/18/26.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @AppStorage("currency_preference")
    private var selectedCurrency = "USD"
    
    @Environment(\.dismiss)
        private var dismiss
    
    var body: some View {

        NavigationStack {

            List {

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

struct SettingsView_Previews: PreviewProvider {

    static var previews: some View {

        SettingsView()

    }

}
