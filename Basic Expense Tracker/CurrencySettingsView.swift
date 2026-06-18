//
//  CurrencySettingsView.swift
//  Basic Expense Tracker
//
//  Created by Nguyen Nha on 6/18/26.
//

import Foundation
import SwiftUI

struct CurrencySettingsView: View {

    @AppStorage("currency_preference")
    private var selectedCurrency = "USD"

    let currencies = [
        "USD",
        "EUR",
        "GBP",
        "JPY",
        "VND"
    ]

    var body: some View {

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
