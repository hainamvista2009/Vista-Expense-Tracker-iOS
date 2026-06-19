//
//  CurrencySettingsView.swift
//  Basic Expense Tracker
//
//  Created by Nguyen Nha on 6/18/26.
//

import Foundation
import SwiftUI

struct CurrencySettingsView: View {

    // Use @AppStorage to persist the selected currency across app launches
    @AppStorage("currency_preference")
    private var selectedCurrency = "USD"

    // List of available currencies for selection
    let currencies = [
        "USD",
        "EUR",
        "GBP",
        "JPY",
        "VND"
    ]

    // The body of the view, which displays a list of currencies and allows the user to select one
    var body: some View {

        // Use a List to display the available currencies
        List {

            ForEach(currencies, id: \.self) { currency in

                Button {

                    selectedCurrency = currency

                } label: {

                    HStack {

                        Text(currency)

                        Spacer()

                        if selectedCurrency == currency {

                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)

                        }

                    }

                }
                .foregroundColor(.primary)

            }

        }
        .navigationTitle("Currency")

    }

}
