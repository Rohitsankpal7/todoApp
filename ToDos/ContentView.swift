//
//  ContentView.swift
//  ToDos
//
//  Created by Rohit Sankpal on 14/04/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [
        SortDescriptor(\TodoItem.scheduledDate, order: .reverse),
        SortDescriptor(\TodoItem.createdAt, order: .reverse)
    ])
    private var items: [TodoItem]

    @State private var isPresentingAddSheet = false

    var body: some View {
        NavigationStack {
            List {
                if items.isEmpty {
                    EmptyStateView()
                        .listRowBackground(Color.clear)
                } else {
                    ForEach(groupedItems) { section in
                        Section(section.title) {
                            ForEach(section.items) { item in
                                TodoRow(item: item) {
                                    toggleCompletion(for: item)
                                }
                            }
                            .onDelete { offsets in
                                deleteItems(offsets: offsets, from: section.items)
                            }
                        }
                    }
                }
            }
#if os(iOS)
            .listStyle(.insetGrouped)
#else
            .listStyle(.sidebar)
#endif
            .scrollContentBackground(.hidden)
            .background(AppTheme.backgroundGradient)
            .navigationTitle("My Todos")
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    addTodoToolbarButton
                }
#else
                ToolbarItem(placement: .primaryAction) {
                    addTodoToolbarButton
                }
#endif
            }
            .sheet(isPresented: $isPresentingAddSheet) {
                AddTodoView { title, notes, scheduledDate in
                    addItem(title: title, notes: notes, scheduledDate: scheduledDate)
                }
            }
        }
    }

    private var addTodoToolbarButton: some View {
        Button {
            isPresentingAddSheet = true
        } label: {
            Label("Add Todo", systemImage: "plus.circle.fill")
        }
    }

    private var groupedItems: [TodoSection] {
        TodoGrouping.groupedSections(from: items)
    }

    private func addItem(title: String, notes: String, scheduledDate: Date) {
        withAnimation {
            let day = Calendar.current.startOfDay(for: scheduledDate)
            let newItem = TodoItem(title: title, notes: notes, scheduledDate: day)
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet, from sectionItems: [TodoItem]) {
        withAnimation {
            for index in offsets {
                modelContext.delete(sectionItems[index])
            }
        }
    }

    private func toggleCompletion(for item: TodoItem) {
        withAnimation {
            item.isCompleted.toggle()
            item.updatedAt = Date()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TodoItem.self, inMemory: true)
}
