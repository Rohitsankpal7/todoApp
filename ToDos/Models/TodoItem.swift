//
//  TodoItem.swift
//  ToDos
//
//  Created by Rohit Sankpal on 14/04/26.
//

import Foundation
import SwiftData

@Model
final class TodoItem {
    var title: String
    var notes: String
    var isCompleted: Bool
    /// Calendar day the task is planned for (start of day in local calendar when saved from the UI).
    var scheduledDate: Date
    var createdAt: Date
    var updatedAt: Date

    init(
        title: String,
        notes: String = "",
        isCompleted: Bool = false,
        scheduledDate: Date,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.title = title
        self.notes = notes
        self.isCompleted = isCompleted
        self.scheduledDate = scheduledDate
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
