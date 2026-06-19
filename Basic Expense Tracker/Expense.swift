//
//  Expense.swift
//  Basic Expense Tracker
//
//  Created by Nguyen Nha on 6/16/26.
//

import Foundation

struct Expense: Identifiable, Codable, Equatable {

    // Unique identifier for each expense, generated using UUID
    let id: UUID

    // Properties to store the amount, category, note, and creation date of the expense
    var amount: Double
    var category: String
    var note: String
    let createdAt: Date

    // Initializer to create a new Expense instance with the provided amount, category, and note. The id is generated automatically, and the createdAt date is set to the current date and time.
    init(
        amount: Double,
        category: String,
        note: String
    ) {
        self.id = UUID()
        self.amount = amount
        self.category = category
        self.note = note
        self.createdAt = Date()
    }
}
