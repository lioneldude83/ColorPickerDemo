# ColorPickerDemo

A SwiftUI demo showing how to use ColorPicker and persist the chosen color in UserDefaults using AppStorage.

## Features

    • SwiftUI ColorPicker integrated into a simple demo view.
    • Selected color is stored as a hex string in AppStorage.
    • Colors persist across app launches.
    • Conversion between Color ↔ Hex String with a helper extension.
    • Option to disable opacity if you only want solid colors.

## Setup

    1. Download ColorPickerView.swift from this repo.
    2. Create a new SwiftUI project in Xcode.
    3. Add ColorPickerView.swift to your project.
    4. Run the app on the simulator or device.

## Storing Color in UserDefaults

Since UserDefaults only supports basic types (Int, String, etc.), we convert the selected color into a hex string before saving.
    • Example: #FF0000FF → Red with full opacity.
    • The stored string is restored back to a Color on app launch.

This is handled with the included Color extension.

## Screenshots

| Demo | Color Picker |
|------|--------------|
| ![Selected color](Screenshots/ColorPickerView1.jpeg) | ![Color picker grid](Screenshots/SelectAColor-WithOpacitySlider.jpeg) |

## Example Code

        ColorPicker("Select a Color", selection: $selectedColor, supportsOpacity: true)
            .padding()
            .frame(maxWidth: .infinity)
        
        Text("Selected Color: \(colorHex)")
            .font(.headline)
            .foregroundStyle(selectedColor)
