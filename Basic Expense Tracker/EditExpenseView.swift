//
//  EditExpenseView.swift
//  Basic Expense Tracker
//
//  Created by Nguyen Nha on 6/17/26.
//

import Foundation
import SwiftUI

struct EditExpenseView: View {

    @Environment(\.dismiss) private var dismiss

    @Binding var expense: Expense

    var body: some View {

        NavigationStack {

            Form {

                Section("Amount") {

                    TextField(
                        "Amount",
                        value: $expense.amount,
                        format: .number
                    )
                    .keyboardType(.decimalPad)

                }

                Section("Category") {

                    Picker(
                        "Category",
                        selection: $expense.category
                    ) {

                        Text("Food").tag("Food")
                        Text("Transport").tag("Transport")
                        Text("Rent").tag("Rent")
                        Text("Shopping").tag("Shopping")
                        Text("Entertainment").tag("Entertainment")

                    }

                }

                Section("Note") {

                    TextField(
                        "Optional note",
                        text: $expense.note
                    )

                }

            }
            .navigationTitle("Edit Expense")
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

struct EditExpenseView_Previews: PreviewProvider {

    static var previews: some View {

        EditExpenseView(
            expense: .constant(
                Expense(
                    amount: 199.0,
                    category: "Transport",
                    note: "Test note"
                )
            )
        )

    }

}
