//
//  TodoRow.swift
//  ToDos
//
//  Created by Rohit Sankpal on 14/04/26.
//

import SwiftUI

struct TodoRow: View {
    let item: TodoItem
    let onToggle: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Button(action: onToggle) {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundStyle(item.isCompleted ? AppTheme.success : AppTheme.accent)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(item.isCompleted ? "Mark as not completed" : "Mark as completed")

            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.headline)
                    .foregroundStyle(AppTheme.primaryText)
                    .strikethrough(item.isCompleted, color: AppTheme.mutedText)

                if !item.notes.isEmpty {
                    Text(item.notes)
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.mutedText)
                        .lineLimit(2)
                }

                HStack(spacing: 4) {
                    Image(systemName: "calendar")
                        .imageScale(.small)
                    Text(item.scheduledDate.formatted(date: .abbreviated, time: .omitted))
                }
                .font(.caption)
                .foregroundStyle(AppTheme.mutedText)
            }
        }
        .padding(.vertical, 4)
    }
}
