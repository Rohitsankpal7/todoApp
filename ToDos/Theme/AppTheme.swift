//
//  AppTheme.swift
//  ToDos
//
//  Created by Rohit Sankpal on 14/04/26.
//

import SwiftUI

enum AppTheme {
    static let accent = Color(red: 0.30, green: 0.48, blue: 0.95)
    static let success = Color(red: 0.18, green: 0.67, blue: 0.42)
    static let primaryText = Color.primary
    static let mutedText = Color.secondary

    static func backgroundGradient(for colorScheme: ColorScheme) -> LinearGradient {
        let colors: [Color]
        switch colorScheme {
        case .dark:
            colors = [
                Color(red: 0.08, green: 0.10, blue: 0.16),
                Color(red: 0.12, green: 0.09, blue: 0.18)
            ]
        default:
            colors = [
                Color(red: 0.93, green: 0.96, blue: 1.00),
                Color(red: 0.98, green: 0.94, blue: 1.00)
            ]
        }

        return LinearGradient(
            colors: colors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
