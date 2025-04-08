# NextToGo App

## Overview

This is a sample iOS app built with Swift 6. The app demonstrates basic functionalities and integrates unit tests using Swift Testing (Testing framework) and follows modern iOS development practices.

## Features

- Built with **Swift 6**
- Integrated **unit testing** with **SwiftTest**
- Uses modern iOS architectures ( **MVVM**, **Clean**.)
- Supports **Swift Data** and **Accessibility**
- Optimized for **iPhone**

## Requirements

- Xcode 16 or higher
- Swift 6
- iOS 18.0 or later

## Installation

1. Clone the repository:
    ```bash
   git clone https://github.com/vishnusasikumar/NextToGo.git
   cd NextToGo
2. Open the project in Xcode:
    ```bash
    open NextToGo.xcodeproj
3. Build the project:
   Select the target device or simulator and press Cmd + R to build and run the app.

## Testing

This project uses SwiftTest for unit testing. You can run the tests through Xcode or from the terminal.

### Running Tests in Xcode
1. Open the Test Navigator in Xcode (Cmd + 5).
2. Select the test suite you want to run.
3. Click the Run button.

### Running Tests from Terminal
1. You can run all tests via the command line using xcodebuild:
    ```bash
    xcodebuild test -scheme NextToGo -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.0'
2. You can also run a specific test file:
    ```bash
    xcodebuild test -scheme NextToGo -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.0' -only-testing NextToGoTests/DataTests/RepositoryTests


## Folder Structure
The folder structure of the project is organized as follows:
    ```bash
    NextToGoApp/
├── NextToGoApp.swift          # App entry point
├── ContentView.swift          # Main content view with all Dependencies
├── Data/                      # Data models and model-related code
├── Views/                     # UI components
├── ViewModels/                # ViewModel layer (MVVM)
├── Domain/                    # Use Cases, Repositories and main Entity
├── Utilities/                 # Helper classes, extensions, etc.
├── Tests/                     # Unit and UI tests
│   ├── DataTests/             # Unit tests for Repository layer
│   └── DomainTests/           # Unit tests for UseCase layer
└── NextToGo.xcodeproj         # Xcode project file


## Acknowledgements
* Swift 6 and SwiftUI for UI development
* SwiftTest for unit testing
* Xcode for development
