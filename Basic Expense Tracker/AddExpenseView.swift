//
//  AddExpenseView.swift
//  Basic Expense Tracker
//
//  Created by Nguyen Nha on 6/15/26.
//

import Foundation
import SwiftUI

struct AddExpenseView: View {
    // Use @Environment to access the dismiss function, which allows us to close the view when the user is done adding a new expense
    @Environment(\.dismiss) var dismiss
    // Use @Binding to allow the view to modify the list of expenses passed in from the parent view
    @Binding var expenses: [Expense]
    // State variables to hold the input values for the new expense being added
    @State private var amount = ""
    @State private var category = "Food"
    @State private var note = ""
    // List of available categories for the user to select when adding a new expense
    let categories = [
        "Food",
        "Transport",
        "Rent",
        "Shopping",
        "Entertainment",
        "Other"
    ]
    // The body of the view, which contains a form for entering the details of the new expense and buttons to cancel or add the expense
    var body: some View {

        NavigationStack {

            Form {
                // Section for entering the amount of the new expense, which includes a text field that accepts decimal input
                Section("Amount") {

                    TextField(
                        "Enter amount",
                        text: $amount
                    )
                    .keyboardType(.decimalPad)

                }
                // Section for selecting the category of the new expense, which includes a picker that allows the user to choose from a predefined list of categories
                Section("Category") {

                    Picker(
                        "Category",
                        selection: $category
                    ) {

                        ForEach(categories, id: \.self) {
                            Text($0)
                        }

                    }

                }
                // Section for entering an optional note about the new expense, which includes a text field for the user to provide additional details if desired
                Section("Note") {

                    TextField(
                        "Optional note",
                        text: $note
                    )

                }

            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            // Toolbar with buttons to cancel adding the expense or to add the expense to the list
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

                    Button("Add") {
                        guard let amountValue = Double(amount) else {
                                return
                            }

                            let expense = Expense(
                                amount: amountValue,
                                category: category,
                                note: note
                            )

                            expenses.append(expense)

                            dismiss()
                    }

                }

            }

        }
    }
}	

// Preview provider for SwiftUI previews, which allows us to see a preview of the AddExpenseView with an empty list of expenses
struct AddExpenseView_Previews: PreviewProvider {

    static var previews: some View {

        AddExpenseView(
            expenses: .constant([])
        )

    }

}
