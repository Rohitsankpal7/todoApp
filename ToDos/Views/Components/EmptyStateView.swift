//
//  EmptyStateView.swift
//  ToDos
//
//  Created by Rohit Sankpal on 14/04/26.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "checklist")
                .font(.system(size: 42))
                .foregroundStyle(AppTheme.accent)

            Text("No todos yet")
                .font(.title3.weight(.semibold))
                .foregroundStyle(AppTheme.primaryText)

            Text("Tap the plus button to add your first task.")
                .font(.subheadline)
                .foregroundStyle(AppTheme.mutedText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 36)
    }
}
