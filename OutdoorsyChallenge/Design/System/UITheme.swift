//
//  UITheme.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 3.10.23.
//

import SwiftUI

// TODO: Could be split in files
// TODO: Use custom colors and fonts - remove SwiftUI import - make it more reusable

// MARK: - Design System definition
protocol UITheme {
    var colors: ColorPalette { get }
    var typography: Typography { get }
    var spacing: SpacingScale { get }
}

protocol ColorPalette {
    var primary: Color { get }
    var text: Color { get }
    var error: Color { get }
}

protocol Typography {
    var title: Font { get }
    var description: Font { get }
}

protocol SpacingScale {
    var small: CGFloat { get }
    var large: CGFloat { get }
}

// MARK: - Main Theme definition
struct MainTheme: UITheme {
    
    var colors: ColorPalette { return MainThemeColorPalette() }
    var typography: Typography { return MainThemeTypography() }
    var spacing: SpacingScale { return MainThemeSpacingScale() }
}

struct MainThemeTypography: Typography {
    var title: Font { return .headline }
    var description: Font { return .subheadline }
}

struct MainThemeColorPalette: ColorPalette {
    var primary: Color { return Color(.elm) }
    var text: Color { return .gray }
    var error: Color { return .red }
}

struct MainThemeSpacingScale: SpacingScale {
    var small: CGFloat { return 8.0 }
    var large: CGFloat { return 16.0 }
}

//MARK: - SwiftUI Environment
private struct ThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue: UITheme = MainTheme()
}

extension EnvironmentValues {
    var currentTheme: UITheme {
        get { self[ThemeEnvironmentKey.self] }
        set { self[ThemeEnvironmentKey.self] = newValue }
    }
}
