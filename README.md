# Vista Expense Tracker

A clean and intuitive iOS expense tracking application built with SwiftUI. Track your spending by category, search expenses, and visualize your spending patterns with ease.

## Status: 🚀 Public Internal Beta (v0.3)

This is currently in **public internal beta** stage. We're actively developing new features and improving the app based on feedback. Thank you for being part of our beta testing journey!

> **Note:** This repository is private during beta testing. Public access will be available upon official release.

## Overview

Vista Expense Tracker is a personal finance management tool designed to help users monitor their daily expenses. Users can add expenses with specific amounts, categorize them, and add notes for each transaction.

**Key Concept:** A log where users can type in an expense amount, select a category, and see a history of what they spent. The data stays saved even if they close the app using SwiftUI's simple @AppStorage and Codable protocols.

## Current Features

✅ **Add Expenses** - Easily add new expenses with amount, category, and optional notes

✅ **Edit Expenses** - Modify existing expenses anytime

✅ **Delete Expenses** - Remove expenses with swipe-to-delete functionality

✅ **Category Management** - Organize expenses into predefined categories:
   - 🍴 Food
   - 🚗 Transport
   - 🏠 Rent
   - 🛍️ Shopping
   - 📺 Entertainment
   - 💰 Other (default)

✅ **Expense History** - View all expenses grouped by date:
   - Today
   - Yesterday
   - Specific dates

✅ **Total Spending Calculation** - See your total expenses at a glance

✅ **Category Totals Breakdown** - Expandable card showing spending by category with icons

✅ **Date Filtering** - Filter expenses by time period:
   - All time
   - Today
   - This Week
   - This Month
   - This Year

✅ **Search Functionality** - Search through expenses using keywords to find specific transactions quickly

✅ **Date-Sectioned List** - View expenses organized and grouped by date for better organization

✅ **Edit Mode** - Edit button for bulk expense management

✅ **Persistent Storage** - Data automatically saves using UserDefaults and JSONEncoder/Decoder

✅ **Responsive UI** - Clean, intuitive interface with SwiftUI

✅ **Empty State** - Helpful message when no expenses exist

## Technical Requirements

### Xcode Version
- **Xcode 14.3.1** (Compatibility: Xcode 14.0+)

### iOS Version
- **Minimum Deployment Target:** iOS 16.0
- **Target Device Family:** iPhone and iPad

### Development Environment
- **Language:** Swift 5.0
- **Framework:** SwiftUI
- **Build System:** Modern Xcode project configuration

## Project Structure

```
Basic Expense Tracker/
├── Basic_Expense_TrackerApp.swift      # App entry point
├── ContentView.swift                   # Main expense list view
├── AddExpenseView.swift                # Add expense sheet
├── EditExpenseView.swift               # Edit expense view
├── ExpenseRow.swift                    # Individual expense row component
├── Expense.swift                       # Expense data model
├── Assets.xcassets                     # App icons and assets
└── Preview Content/
    └── Preview Assets.xcassets         # Preview assets for development
```

## Core Components

### Expense Model (`Expense.swift`)
- **UUID:** Unique identifier for each expense
- **Amount:** Double value for expense amount
- **Category:** String categorization
- **Note:** Optional description
- **CreatedAt:** Timestamp of creation
- **Conformances:** Identifiable, Codable (for persistence), Equatable

### Data Persistence
- Uses **UserDefaults** for simple, fast local storage
- Implements **JSONEncoder/JSONDecoder** for complex data structures
- Automatic save on expense changes

### Date Filtering
Supported filters with `DateFilter` enum:
- All (show all expenses)
- Today (current day)
- This Week
- This Month
- This Year

## Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/hainamvista2009/Vista-Expense-Tracker-iOS.git
   cd Vista-Expense-Tracker-iOS
   ```

2. **Open in Xcode**
   ```bash
   open "Basic Expense Tracker.xcodeproj"
   ```

3. **Select a simulator or device**
   - Ensure you have a simulator running iOS 16.0 or later
   - Or connect your iOS device

4. **Build and Run**
   - Press `Cmd + R` or click the Run button

## Usage Guide

### Adding an Expense
1. Tap the **+** button in the top-right corner
2. Enter the expense amount
3. Select a category from the dropdown
4. Add an optional note
5. Tap "Save" to add the expense

### Editing an Expense
1. Tap on an expense in the list
2. Modify the details
3. Tap "Update" to save changes

### Deleting an Expense
1. Swipe left on an expense
2. Tap the delete button
3. Or use the Edit button to select multiple expenses

### Viewing Category Totals
1. Tap the "Total Spent" card to expand/collapse
2. View spending breakdown by category with icons

### Filtering Expenses
1. Use the segmented picker to select a date range
2. List automatically updates with filtered results

### Searching Expenses
1. Use the search bar to find expenses
2. Type keywords to filter results

## Version Information

- **App Version:** 0.3 (Public Internal Beta)
- **Build Number:** 3
- **Bundle Identifier:** Vista.Basic-Expense-Tracker
- **Status:** 🚀 Beta Testing

## Technologies Used

- **SwiftUI** - Declarative UI framework
- **UserDefaults** - Persistent local storage
- **Codable Protocol** - JSON serialization
- **Navigation Stack** - Modern navigation pattern
- **Calendar Framework** - Date calculations and formatting

## Data Model

The `Expense` struct stores:
- Unique identifier (UUID)
- Amount (Double)
- Category (String)
- Note (String)
- Creation timestamp (Date)

All expenses are automatically encoded to JSON and stored locally on device.

## Beta Testing & Feedback

We're in an active beta phase and appreciate your feedback! If you encounter any issues or have suggestions, please report them through:
- Issue reporting (for beta testers)
- Direct feedback channels

Your input helps us improve Vista Expense Tracker!

## Future Enhancements

Potential features for future versions:
- 📊 Charts and graphs for spending visualization
- 📤 Export expenses to CSV
- 💼 Budget setting and alerts
- 🏷️ Custom categories
- 📱 iCloud sync
- 🌙 Dark mode optimization
- 💱 Multiple currency support
- 📈 Monthly/yearly reports
- 🔔 Spending notifications

## Roadmap to Public Release

- **v0.3** (Current) - Internal Beta with core features
- **v0.4** - Bug fixes and performance improvements based on beta feedback
- **v0.5** - Additional features and refinements
- **v1.0** - Official public release

## License

This project is open source and available under the MIT License.

## Author

Created by **Vista2009** (hainamvista2009)

---

**Thank you for testing Vista Expense Tracker! Your feedback makes us better. 💰**
