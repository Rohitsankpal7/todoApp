# ToDo App
A clean SwiftUI Todo app built with SwiftData, focused on good structure, readable code, and a friendly modern UI.
## Features
- Create todos with title, notes, and scheduled date
- Future planning support with calendar picker (past dates disabled)
- Smart grouping:
  - Current month: grouped day-wise (`Today`, `Tomorrow`, etc.)
  - Older tasks: grouped month-wise (for example, `March 2026`)
- Mark task complete/incomplete
- Celebration animation (confetti/crackers style) on task completion
- Light and Dark mode support
- Local persistence using SwiftData

## Tech Stack
- Swift
- SwiftUI
- SwiftData
- XCTest / XCUITest

## Project Structure
```text
ToDos/
  Models/
    TodoItem.swift
    TodoGrouping.swift
    TodoSection.swift
  Theme/
    AppTheme.swift
  Views/
    Components/
      AddTodoView.swift
      EmptyStateView.swift
      TodoRow.swift
    Effects/
      ConfettiBurstView.swift
  ContentView.swift
  ToDosApp.swift
```

## Run the App
1. Open `ToDos.xcodeproj` in Xcode.
2. Select an iOS Simulator.
3. Build and run (`Cmd + R`).
## Notes
- Data is stored on-device through SwiftData.
- If you make breaking model changes during development, you may need to reset the app data/store.

# Screenshots

<img width="368" height="800" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-15 at 19 54 46" src="https://github.com/user-attachments/assets/e4aef00f-39a1-4d0b-bfce-4a51e354665c" /> <img width="368" height="800" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-15 at 19 53 32" src="https://github.com/user-attachments/assets/d4d78f9c-bb57-4bd5-ab13-46a136d0fdc4" />
<img width="368" height="800" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-15 at 19 53 25" src="https://github.com/user-attachments/assets/e6cd2625-6622-4541-b074-0bf05f8ef7cc" /> <img width="368" height="800" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-15 at 19 53 17" src="https://github.com/user-attachments/assets/7e089849-dd92-43a8-82b2-ba5acdb48458" />

