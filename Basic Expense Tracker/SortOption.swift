//
//  SortOption.swift
//  Basic Expense Tracker
//
//  Created by Nguyen Nha on 6/24/26.
//

import Foundation

enum SortOption: String, CaseIterable {

    case newest = "Newest First"
    case oldest = "Oldest First"
    case highestAmount = "Highest Amount"
    case lowestAmount = "Lowest Amount"

}
