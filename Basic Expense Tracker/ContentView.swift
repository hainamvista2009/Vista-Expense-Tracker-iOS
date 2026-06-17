//
//  ContentView.swift
//  Basic Expense Tracker
//
//  Created by Nguyen Nha on 6/15/26.
//

import SwiftUI

struct ContentView: View {
    private let expensesKey = "savedExpenses"
    
    @State private var showAddExpense = false
    @State private var selectedExpense: Expense?
    @State private var expenses: [Expense] = []
    @State private var showCategoryTotals = false
    @State private var searchText = ""
    
    var totalSpent: Double {
            expenses.reduce(0) { total, expense in
                total + expense.amount
            }
    }
    
    func deleteExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }

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

                        Text(String(format: "$%.2f", totalSpent))
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("\(expenses.count) expense(s)")
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
                                            format: "$%.2f",
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

                    // Expense List
                    if expenses.isEmpty {

                        Spacer()

                        VStack(spacing: 16) {

                            Image(systemName: "tray")
                                .font(.system(size: 60))
                                .foregroundColor(.secondary)

                            Text("No Expenses Yet")
                                .font(.title2)
                                .fontWeight(.semibold)

                            Text("Tap + to add your first expense.")
                                .foregroundColor(.secondary)

                        }

                        Spacer()

                    } else {

                        List {

                            ForEach(expenses) { expense in

                                ExpenseRow(
                                    icon: iconForCategory(expense.category),
                                    category: expense.category,
                                    amount: String(
                                        format: "$%.2f",
                                        expense.amount
                                    ),
                                    note: expense.note,
                                    createdAt: expense.createdAt
                                )
                                .onTapGesture {

                                    selectedExpense = expense

                                }
                                .sheet(item: $selectedExpense) { expense in

                                    if let binding =
                                        bindingForExpense(expense) {

                                        EditExpenseView(
                                            expense: binding
                                        )

                                    }

                                }
                            }
                            .onDelete(perform: deleteExpense)

                        }
                        .listStyle(.plain)

                    }
                }
                .navigationTitle("Expense Tracker")
                .searchable(
                    text: $searchText,
                    prompt: "Search expenses..."
                )
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {

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
            }
            .onAppear {
                loadExpenses()
            }
            .onChange(of: expenses) { _ in
                saveExpenses()
            }
        }
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
            return "dollarsign.circle.fill"
        }
    }
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
    
    var categoryTotals: [String: Double] {

        Dictionary(
            grouping: expenses,
            by: { $0.category }
        )
        .mapValues { expenses in
            expenses.reduce(0) { total, expense in
                total + expense.amount
            }
        }

    }
    
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
