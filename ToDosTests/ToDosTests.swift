//
//  ToDosTests.swift
//  ToDosTests
//
//  Created by Rohit Sankpal on 14/04/26.
//

import XCTest
@testable import ToDos

final class ToDosTests: XCTestCase {

    private var calendar: Calendar {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        return cal
    }

    func testGroupingCurrentMonthUsesDaySectionsAndOlderMonthUsesMonthSection() {
        let ref = calendar.date(from: DateComponents(year: 2026, month: 4, day: 15, hour: 12))!
        let todayStart = calendar.startOfDay(for: ref)
        let todayItem = TodoItem(title: "Today task", scheduledDate: todayStart, createdAt: ref, updatedAt: ref)
        let yesterday = calendar.date(byAdding: .day, value: -1, to: ref)!
        let yesterdayStart = calendar.startOfDay(for: yesterday)
        let yesterdayItem = TodoItem(title: "Yesterday task", scheduledDate: yesterdayStart, createdAt: yesterday, updatedAt: yesterday)
        let marchDate = calendar.date(from: DateComponents(year: 2026, month: 3, day: 10))!
        let marchStart = calendar.startOfDay(for: marchDate)
        let olderItem = TodoItem(title: "March task", scheduledDate: marchStart, createdAt: marchDate, updatedAt: marchDate)

        let sections = TodoGrouping.groupedSections(
            from: [todayItem, yesterdayItem, olderItem],
            referenceDate: ref,
            calendar: calendar
        )

        XCTAssertEqual(sections.count, 3)
        XCTAssertEqual(sections[0].title, "Today")
        XCTAssertEqual(sections[1].title, "Yesterday")
        XCTAssertEqual(sections[2].title, "March 2026")
        XCTAssertEqual(sections[0].items.map(\.title), ["Today task"])
        XCTAssertEqual(sections[1].items.map(\.title), ["Yesterday task"])
        XCTAssertEqual(sections[2].items.map(\.title), ["March task"])
    }

    func testGroupingShowsTomorrowForDayAfterReference() {
        let ref = calendar.date(from: DateComponents(year: 2026, month: 4, day: 15))!
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: ref)!
        let tomorrowStart = calendar.startOfDay(for: tomorrow)
        let item = TodoItem(title: "Future", scheduledDate: tomorrowStart, createdAt: ref, updatedAt: ref)

        let sections = TodoGrouping.groupedSections(from: [item], referenceDate: ref, calendar: calendar)

        XCTAssertEqual(sections.count, 1)
        XCTAssertEqual(sections[0].title, "Tomorrow")
    }

    func testGroupingSortsSectionsNewestFirst() {
        let ref = calendar.date(from: DateComponents(year: 2026, month: 4, day: 15))!
        let aprilFirst = calendar.date(from: DateComponents(year: 2026, month: 4, day: 1))!
        let a = TodoItem(title: "Older in month", scheduledDate: calendar.startOfDay(for: aprilFirst), createdAt: aprilFirst, updatedAt: aprilFirst)
        let b = TodoItem(title: "Newer in month", scheduledDate: calendar.startOfDay(for: ref), createdAt: ref, updatedAt: ref)

        let sections = TodoGrouping.groupedSections(from: [a, b], referenceDate: ref, calendar: calendar)
        XCTAssertEqual(sections.count, 1)
        XCTAssertEqual(sections[0].items.map(\.title), ["Newer in month", "Older in month"])
    }
}
