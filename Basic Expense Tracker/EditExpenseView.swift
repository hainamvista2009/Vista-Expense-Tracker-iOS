//
//  EditExpenseView.swift
//  Basic Expense Tracker
//
//  Created by Nguyen Nha on 6/17/26.
//

import Foundation
import SwiftUI

struct EditExpenseView: View {

    // Use @Environment to access the dismiss function, which allows us to close the view when the user is done editing
    @Environment(\.dismiss) private var dismiss
    // Use @Binding to allow the view to modify the expense passed in from the parent view
    @Binding var expense: Expense

    // The body of the view, which contains a form for editing the expense details
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
                    placement: .navigationBarLeading
                ) {

                    Button("Cancel") {

                        dismiss()

                    }

                }

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

// Preview provider for SwiftUI previews, which allows us to see a preview of the EditExpenseView with some sample data
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
