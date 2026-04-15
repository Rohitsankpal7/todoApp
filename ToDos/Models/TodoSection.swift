//
//  TodoSection.swift
//  ToDos
//
//  Created by Rohit Sankpal on 14/04/26.
//

import Foundation

struct TodoSection: Identifiable {
    let title: String
    let sortDate: Date
    let items: [TodoItem]

    var id: String { "\(title)-\(sortDate.timeIntervalSince1970)" }
}

struct GroupKey: Hashable {
    let kind: GroupingKind
    let date: Date
}

enum GroupingKind: Hashable {
    case day
    case month
}
