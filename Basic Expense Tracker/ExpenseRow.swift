//
//  ExpenseRow.swift
//  Basic Expense Tracker
//
//  Created by Nguyen Nha on 6/15/26.
//

import Foundation
import SwiftUI

struct ExpenseRow: View {

    // Properties to display the expense details in the row
    let icon: String
    let category: String
    let amount: String
    let note: String
    let createdAt: Date
    
    // Computed property to format the createdAt date into a user-friendly string for display in the row
    private var formattedDate: String {
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter.string(from: createdAt)
    }
    
    // The body of the view, which defines the layout and appearance of the expense row in the list
    var body: some View {

        HStack(alignment: .top) {

            Image(systemName: icon)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 4){
                Text(category)
                    .font(.headline)
                
                if !note.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Text(note)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Text(formattedDate)
                    .font(.caption2)
                    .foregroundColor(.gray)

            }
            
            
            Spacer()

            Text(amount)
                .fontWeight(.semibold)

        }
        .padding(.vertical, 4)
    }
}

// Preview provider for SwiftUI previews, which allows us to see a preview of the ExpenseRow with some sample data
struct ExpenseRow_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseRow(
            icon: "fork.knife",
            category: "Food",
            amount: "$12.50",
            note: "Test",
            createdAt: Date()
        )
    }
}
