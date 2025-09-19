import 'package:flutter/material.dart';

String _appTheme = "lightCode";
LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

  // A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light();
}

class LightCodeColors {
  // App Colors
  Color get black => Color(0xFF1E1E1E);
  Color get white => Color(0xFFFFFFFF);
  Color get gray600 => Color(0xFF4B5563);
  Color get gray800 => Color(0xFF1F2937);
  Color get gray400 => Color(0xFF9CA3AF);
  Color get gray900 => Color(0xFF111827);

  // Additional Colors
  Color get whiteCustom => Colors.white;
  Color get blackCustom => Colors.black;
  Color get greenCustom => Colors.green;
  Color get transparentCustom => Colors.transparent;
  Color get greyCustom => Colors.grey;
  Color get colorFF1C1A => Color(0xFF1C1A1F);
  Color get colorFF1B19 => Color(0xFF1B191E);
  Color get colorFF4947 => Color(0xFF49474B);
  Color get colorFF2D2B => Color(0xFF2D2B30);
  Color get colorFFBE7A => Color(0xFFBE7A85);
  Color get colorFF3418 => Color(0xFF3418A1);
  Color get color19ED3E => Color(0x19ED3E3E);
  Color get colorFF0908 => Color(0xFF09080D);
  Color get colorFFA5A9 => Color(0xFFA5A9BA);
  Color get colorFF00B8 => Color(0xFF00B831);
  Color get colorFF1118 => Color(0xFF111827);
  Color get colorFF6B72 => Color(0xFF6B7280);
  Color get colorFF9CA3 => Color(0xFF9CA3AF);
  Color get colorFF8888 => Color(0xFF888888);
  Color get colorFF6B46 => Color(0xFF6B46C1);
  Color get colorFF24F0 => Color(0xFF24F07D);
  Color get colorFF0A08 => Color(0xFF0A080E);
  Color get colorFF2D1B => Color(0xFF2D1B3D);
  Color get colorFF1A1A => Color(0xFF1A1A1A);
  Color get colorFF2D2D => Color(0xFF2D2D2D);
  Color get colorFF6666 => Color(0xFF666666);
  Color get colorFF2523 => Color(0xFF252327);
  Color get colorFF3741 => Color(0xFF374151);
  Color get colorFFFF45 => Color(0xFFFF4545);

  // Color Shades - Each shade has its own dedicated constant
  Color get grey200 => Colors.grey.shade200;
  Color get grey100 => Colors.grey.shade100;
}
