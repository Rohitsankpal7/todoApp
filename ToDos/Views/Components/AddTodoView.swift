//
//  AddTodoView.swift
//  ToDos
//
//  Created by Rohit Sankpal on 14/04/26.
//

import SwiftUI

struct AddTodoView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var notes = ""
    @State private var scheduledDate = Date()

    let onSave: (_ title: String, _ notes: String, _ scheduledDate: Date) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section("Todo Details") {
                    TextField("Title", text: $title)
                    TextField("Notes", text: $notes, axis: .vertical)
                        .lineLimit(3...5)
                }
                Section("When") {
                    DatePicker(
                        "Due date",
                        selection: $scheduledDate,
                        in: Date()...,
                        displayedComponents: .date
                    )
#if os(iOS)
                    .datePickerStyle(.graphical)
#endif
                }
            }
            .navigationTitle("New Todo")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(cleanTitle, cleanNotes, scheduledDate)
                        dismiss()
                    }
                    .disabled(cleanTitle.isEmpty)
                }
            }
        }
#if os(iOS)
        .presentationDetents([.medium])
#endif
    }

    private var cleanTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var cleanNotes: String {
        notes.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
