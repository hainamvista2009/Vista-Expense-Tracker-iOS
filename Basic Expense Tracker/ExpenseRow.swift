//
//  ExpenseRow.swift
//  Basic Expense Tracker
//
//  Created by Nguyen Nha on 6/15/26.
//

import Foundation
import SwiftUI

struct ExpenseRow: View {

    let icon: String
    let category: String
    let amount: String
    let note: String
    let createdAt: Date
    
    private var formattedDate: String {
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter.string(from: createdAt)
    }
    
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
