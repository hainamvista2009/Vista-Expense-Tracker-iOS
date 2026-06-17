//
//  Expense.swift
//  Basic Expense Tracker
//
//  Created by Nguyen Nha on 6/16/26.
//

import Foundation

struct Expense: Identifiable, Codable, Equatable {

    let id: UUID

    var amount: Double
    var category: String
    var note: String
    let createdAt: Date

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
