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

    static let backgroundGradient = LinearGradient(
        colors: [
            Color(red: 0.93, green: 0.96, blue: 1.00),
            Color(red: 0.98, green: 0.94, blue: 1.00)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
