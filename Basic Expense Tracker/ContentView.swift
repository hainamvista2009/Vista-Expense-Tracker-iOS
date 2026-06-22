//
//  ContentView.swift
//  Basic Expense Tracker
//
//  Created by Nguyen Nha on 6/15/26.
//

import SwiftUI

// Currency options for the app
enum Currency: String, CaseIterable {

    case usd = "USD ($)"
    case eur = "EUR (€)"
    case gbp = "GBP (£)"
    case jpy = "JPY (¥)"
    case vnd = "VND (₫)"

}

// Date filter options for the expense list
enum DateFilter: String, CaseIterable {

    case all = "All"
    case today = "Today"
    case week = "This Week"
    case month = "This Month"
    //case year = "This Year"
}

// Category filter options for the expense list
enum CategoryFilter: String, CaseIterable {

    case all = "All Categories"
    case food = "Food"
    case transport = "Transport"
    case rent = "Rent"
    case shopping = "Shopping"
    case entertainment = "Entertainment"

}

struct ContentView: View {
    private let expensesKey = "savedExpenses"
    
    @State private var showAddExpense = false
    @State private var selectedExpense: Expense?
    @State private var expenses: [Expense] = []
    @State private var showCategoryTotals = false
    @State private var searchText = ""
    @State private var selectedDateFilter: DateFilter = .all
    @State private var selectedCategory: CategoryFilter = .all
    @State private var showSettings = false
    
    @AppStorage("currency_preference")
    private var selectedCurrency = "USD"
    
    // Calculate total spent based on filtered expenses
    var totalSpent: Double {

        filteredExpenses.reduce(0) {
            $0 + $1.amount
        }

    }
    
    // Function to delete an expense from the list
    func deleteExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }

    // Main view body
    var body: some View {
            NavigationStack {
                VStack(spacing: 16) {

                    // Total Card
                    VStack(alignment: .leading, spacing: 8) {

                        HStack {

                            Text("Total Spent")
                                .font(.headline)
                                .foregroundColor(.secondary)

                            Spacer()

                            Image(
                                systemName:
                                    showCategoryTotals
                                    ? "chevron.up"
                                    : "chevron.down"
                            )
                            .foregroundColor(.secondary)

                        }

                        Text(
                            String(
                                format: "\(currencySymbol())%.2f",
                                totalSpent
                            )
                        )
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("\(filteredExpenses.count) expense(s)")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        if showCategoryTotals {

                            Divider()

                            ForEach(
                                categoryTotals.keys.sorted(),
                                id: \.self
                            ) { category in

                                HStack {
                                    Image(systemName: iconForCategory(category))
                                    
                                    Text(category)

                                    Spacer()

                                    Text(
                                        String(
                                            format: "\(currencySymbol())%.2f",
                                            categoryTotals[category] ?? 0
                                        )
                                    )

                                }

                            }

                        }

                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .onTapGesture {

                        withAnimation {

                            showCategoryTotals.toggle()

                        }

                    }
                    
                    // Date Picker
                    Picker(
                        "Date Filter",
                        selection: $selectedDateFilter
                    ) {

                        ForEach(
                            DateFilter.allCases,
                            id: \.self
                        ) { filter in

                            Text(filter.rawValue)
                                .tag(filter)

                        }

                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    
                    // Category
                    Menu {

                        ForEach(
                            CategoryFilter.allCases,
                            id: \.self
                        ) { category in

                            Button {

                                selectedCategory = category

                            } label: {

                                if selectedCategory == category {

                                    Label(
                                        category.rawValue,
                                        systemImage: "checkmark"
                                    )

                                } else {

                                    Label(
                                        category.rawValue,
                                        systemImage:
                                            iconForCategory(category.rawValue)
                                    )

                                }

                            }

                        }

                    } label: {

                        HStack {

                            Image(
                                systemName:
                                    "line.3.horizontal.decrease.circle"
                            )

                            Text(selectedCategory.rawValue)

                            Spacer()

                            Image(systemName: "chevron.down")

                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)

                    }
                    .padding(.horizontal)
                    
                    // Expense List
                    if expenses.isEmpty {

                        emptyExpensesView

                    } else if filteredExpenses.isEmpty {

                        emptySearchView

                    } else {
                        
                        List {

                            ForEach(groupedExpenses, id: \.0) { date, expenses in

                                Section(
                                    header: Text(
                                        sectionTitle(for: date)
                                    )
                                ) {

                                    ForEach(expenses) { expense in

                                        ExpenseRow(
                                            icon: iconForCategory(expense.category),
                                            category: expense.category,
                                            amount: String(
                                                format: "\(currencySymbol())%.2f",
                                                expense.amount
                                            ),
                                            note: expense.note,
                                            createdAt: expense.createdAt
                                        )
                                        .onTapGesture {

                                            selectedExpense = expense

                                        }

                                    }
                                    .onDelete(
                                        perform: deleteExpense
                                    )

                                }

                            }

                        }
                        .listStyle(.plain)

                    }
                    
                }
                .navigationTitle("Vista Expense Tracker")
                .searchable(
                    text: $searchText,
                    prompt: "Search expenses..."
                )
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    
                    ToolbarItemGroup(
                        placement: .navigationBarTrailing
                    ) {

                        Button {
                            showSettings = true
                        } label: {
                            Image(systemName: "gearshape")
                        }

                        Button {
                            showAddExpense = true
                        } label: {
                            Image(systemName: "plus")
                        }

                    }

                }
                .sheet(isPresented: $showAddExpense) {
                    AddExpenseView(expenses: $expenses)
                }
                .sheet(item: $selectedExpense) { expense in

                    if let binding = bindingForExpense(expense) {

                        EditExpenseView(
                            expense: binding
                        )

                    }

                }
                .sheet(isPresented: $showSettings) {

                    SettingsView(
                        expenses: $expenses
                    )   

                }
            }
            .onAppear {
                loadExpenses()
            }
            .onChange(of: expenses) { _ in
                saveExpenses()
            }
        }

    // Function to get the appropriate icon for each expense category
    func iconForCategory(_ category: String) -> String {

        switch category {

        case "Food":
            return "fork.knife"

        case "Transport":
            return "car.fill"

        case "Rent":
            return "house.fill"

        case "Shopping":
            return "bag.fill"

        case "Entertainment":
            return "tv.fill"

        default:
            return "wallet.pass.fill"
        }
    }

    // Function to save expenses to UserDefaults
    func saveExpenses() {

        do {

            let encoded = try JSONEncoder().encode(expenses)

            UserDefaults.standard.set(
                encoded,
                forKey: expensesKey
            )

        } catch {

            print("Failed to save expenses")

        }
    }

    // Function to load expenses from UserDefaults
    func loadExpenses() {

        guard let data =
            UserDefaults.standard.data(
                forKey: expensesKey
            )
        else {
            return
        }

        do {

            expenses =
                try JSONDecoder().decode(
                    [Expense].self,
                    from: data
                )

        } catch {

            print("Failed to load expenses")

        }
    }
    
    // Calculate total spent per category based on filtered expenses
    var categoryTotals: [String: Double] {

        Dictionary(
            grouping: filteredExpenses,
            by: { $0.category }
        )
        .mapValues { expenses in
            expenses.reduce(0) { total, expense in
                total + expense.amount
            }
        }

    }
    
    // Function to get a binding for a specific expense, used for editing
    func bindingForExpense(
        _ expense: Expense
    ) -> Binding<Expense>? {

        guard let index =
            expenses.firstIndex(where: {
                $0.id == expense.id
            })
        else {
            return nil
        }

        return $expenses[index]
    }
    
    // Function to get the section title based on the date of the expenses
    func sectionTitle(for date: Date) -> String {

        let calendar = Calendar.current

        if calendar.isDateInToday(date) {
            return "Today"
        }

        if calendar.isDateInYesterday(date) {
            return "Yesterday"
        }

        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        return formatter.string(from: date)

    }
    
    // Group expenses by date and sort them in descending order
    var groupedExpenses: [(Date, [Expense])] {

        let grouped = Dictionary(
            grouping: filteredExpenses
        ) { expense in

            Calendar.current.startOfDay(
                for: expense.createdAt
            )

        }

        return grouped
            .sorted {
                $0.key > $1.key
            }

    }
    
    // Filter expenses based on selected date filter, category filter, and search text
    var filteredExpenses: [Expense] {

        let calendar = Calendar.current
        let now = Date()

        let dateFiltered: [Expense]

        switch selectedDateFilter {

        case .all:
            dateFiltered = expenses

        case .today:
            dateFiltered = expenses.filter {
                calendar.isDateInToday($0.createdAt)
            }

        case .week:

            guard let weekAgo =
                calendar.date(
                    byAdding: .day,
                    value: -7,
                    to: now
                )
            else {
                return expenses
            }

            dateFiltered = expenses.filter {
                $0.createdAt >= weekAgo
            }

        case .month:

            guard let monthAgo =
                calendar.date(
                    byAdding: .month,
                    value: -1,
                    to: now
                )
            else {
                return expenses
            }

            dateFiltered = expenses.filter {
                $0.createdAt >= monthAgo
            }

        }
        
        let categoryFiltered = dateFiltered.filter { expense in

            switch selectedCategory {

            case .all:
                return true

            case .food:
                return expense.category == "Food"

            case .transport:
                return expense.category == "Transport"

            case .rent:
                return expense.category == "Rent"

            case .shopping:
                return expense.category == "Shopping"

            case .entertainment:
                return expense.category == "Entertainment"

            }

        }
        
        if searchText.isEmpty {
            return categoryFiltered
        }
        
        return categoryFiltered.filter { expense in

            expense.category.localizedCaseInsensitiveContains(searchText)

            ||

            expense.note.localizedCaseInsensitiveContains(searchText)

        }
        .sorted {
            $0.createdAt > $1.createdAt
        }

    }

    // Function to get the appropriate currency symbol based on the selected currency
    func currencySymbol() -> String {

        switch selectedCurrency {

        case "USD":
            return "$"

        case "EUR":
            return "€"

        case "GBP":
            return "£"

        case "JPY":
            return "¥"

        case "VND":
            return "₫"

        default:
            return "$"

        }

    }
    
    var emptySearchView: some View {

        VStack(spacing: 16) {

            Spacer()

            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.secondary)

            Text("No Results Found")
                .font(.title2)
                .fontWeight(.semibold)
            Text(
                "No results for \"\(searchText)\""
            )
            .foregroundColor(.secondary)

            Text(
                "Try a different keyword or clear your filters."
            )
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)

            Spacer()

        }

    }
    
    var emptyExpensesView: some View {

        VStack(spacing: 16) {

            Spacer()

            Image(systemName: "tray")
                .font(.system(size: 60))
                .foregroundColor(.secondary)

            Text("No Expenses Yet")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Tap + to add your first expense.")
                .foregroundColor(.secondary)

            Spacer()

        }

    }
}

// Preview provider for SwiftUI previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
