//
//  ContentView.swift
//
//  Created by Lionel Ng on 31/8/25.
//

import SwiftUI

struct ColorPickerView: View {
    // Since AppStorage does not accept Color type, we store the hex color as a string
    @AppStorage("colorHex") private var colorHex: String = "#FF0000FF"
    @State private var selectedColor: Color = .red
    
    var body: some View {
        NavigationStack {
            VStack {
                Circle()
                    .fill(selectedColor)
                    .frame(width: 350, height: 350)
                
                ColorPicker("Select a Color", selection: $selectedColor)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                
                Text("Selected Color: \(colorHex)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundStyle(selectedColor)
                    .frame(maxWidth: .infinity)
                
                Spacer()
            }
            .navigationTitle("Color Picker Demo")
            .padding()
            .onAppear {
                // When the view appears, set the Color to read from the stored colorHex string
                if let color = Color(hex: colorHex) {
                    selectedColor = color
                }
            }
            .onChange(of: selectedColor) { _, newColor in
                // React to changes when user changes the color setting in the picker
                colorHex = newColor.hexString
                #if DEBUG
                print("Selected Color: \(colorHex)")
                #endif
            }
        }
    }
}

/// Extension to Color with helpers to convert from Color to hex string and back
extension Color {
    // Convert SwiftUI Color into hex string format
    var hexString: String {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Get the components that form the color in the RGB color space
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // e.g. #FF0000FF
        return String(format: "#%02X%02X%02X%02X",
                      lroundf(Float(red * 255)),
                      lroundf(Float(green * 255)),
                      lroundf(Float(blue * 255)),
                      lroundf(Float(alpha * 255))) // Include alpha component, opacity from 0 to 1
    }
    
    // Convert hex string into SwiftUI Color
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        // Read the hex string and convert into a 64-bit unsigned integer
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        // Use bit masking and shifting to extract red, green, blue and alpha components
        let red = Double((rgb & 0xFF000000) >> 24) / 255.0
        let green = Double((rgb & 0x00FF0000) >> 16) / 255.0
        let blue = Double((rgb & 0x0000FF00) >> 8) / 255.0
        let alpha = Double(rgb & 0x000000FF) / 255.0
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}

#Preview {
    ColorPickerView()
}
