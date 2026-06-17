//
//  AddExpenseView.swift
//  Basic Expense Tracker
//
//  Created by Nguyen Nha on 6/15/26.
//

import Foundation
import SwiftUI

struct AddExpenseView: View {

    @Environment(\.dismiss) var dismiss
    
    @Binding var expenses: [Expense]
    
    @State private var amount = ""
    @State private var category = "Food"
    @State private var note = ""

    let categories = [
        "Food",
        "Transport",
        "Rent",
        "Shopping",
        "Entertainment",
        "Other"
    ]

    var body: some View {

        NavigationStack {

            Form {

                Section("Amount") {

                    TextField(
                        "Enter amount",
                        text: $amount
                    )
                    .keyboardType(.decimalPad)

                }

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

                Section("Note") {

                    TextField(
                        "Optional note",
                        text: $note
                    )

                }

            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)

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

struct AddExpenseView_Previews: PreviewProvider {

    static var previews: some View {

        AddExpenseView(
            expenses: .constant([])
        )

    }

}
