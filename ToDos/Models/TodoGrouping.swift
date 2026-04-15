//
//  TodoGrouping.swift
//  ToDos
//
//  Created by Rohit Sankpal on 14/04/26.
//

import Foundation

enum TodoGrouping {
    static func groupedSections(
        from items: [TodoItem],
        referenceDate: Date = Date(),
        calendar: Calendar = .current
    ) -> [TodoSection] {
        let currentMonthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: referenceDate)) ?? referenceDate

        let grouped = Dictionary(grouping: items) { item in
            let day = calendar.startOfDay(for: item.scheduledDate)
            if calendar.isDate(day, equalTo: currentMonthStart, toGranularity: .month) {
                return GroupKey(kind: .day, date: day)
            }
            return GroupKey(
                kind: .month,
                date: calendar.date(from: calendar.dateComponents([.year, .month], from: day)) ?? day
            )
        }

        return grouped.map { key, value in
            TodoSection(
                title: sectionTitle(for: key, referenceDate: referenceDate, calendar: calendar),
                sortDate: key.date,
                items: value.sorted {
                    if $0.scheduledDate != $1.scheduledDate {
                        return $0.scheduledDate > $1.scheduledDate
                    }
                    return $0.createdAt > $1.createdAt
                }
            )
        }
        .sorted { $0.sortDate > $1.sortDate }
    }

    private static func sectionTitle(for key: GroupKey, referenceDate: Date, calendar: Calendar) -> String {
        let date = key.date
        switch key.kind {
        case .day:
            let startOfReference = calendar.startOfDay(for: referenceDate)
            if calendar.isDate(date, inSameDayAs: startOfReference) {
                return "Today"
            }
            if let yesterday = calendar.date(byAdding: .day, value: -1, to: startOfReference),
               calendar.isDate(date, inSameDayAs: yesterday) {
                return "Yesterday"
            }
            if let tomorrow = calendar.date(byAdding: .day, value: 1, to: startOfReference),
               calendar.isDate(date, inSameDayAs: tomorrow) {
                return "Tomorrow"
            }
            return date.formatted(.dateTime.weekday(.wide).day().month(.abbreviated))
        case .month:
            return date.formatted(.dateTime.month(.wide).year())
        }
    }
}
