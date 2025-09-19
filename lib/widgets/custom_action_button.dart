import 'package:flutter/material.dart';

import '../core/app_export.dart';

/// Custom action button component that supports multiple styling variants
///
/// This component provides a flexible button implementation that can render
/// as either a solid background button or a text-only underlined button.
///
/// @param text - The text to display on the button
/// @param onPressed - Callback function when button is pressed
/// @param variant - The styling variant of the button (solid or textOnly)
/// @param textColor - Optional custom text color
/// @param backgroundColor - Optional custom background color for solid variant
/// @param width - Optional custom width
/// @param height - Optional custom height
/// @param isEnabled - Whether the button is enabled or disabled
class CustomActionButton extends StatelessWidget {
  const CustomActionButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.variant,
    this.textColor,
    this.backgroundColor,
    this.width,
    this.height,
    this.isEnabled,
  }) : super(key: key);

  /// The text to display on the button
  final String text;

  /// Callback function triggered when the button is pressed
  final VoidCallback? onPressed;

  /// The styling variant of the button
  final CustomActionButtonVariant? variant;

  /// Custom text color (overrides variant default)
  final Color? textColor;

  /// Custom background color for solid variant
  final Color? backgroundColor;

  /// Custom width of the button
  final double? width;

  /// Custom height of the button
  final double? height;

  /// Whether the button is enabled
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    final effectiveVariant = variant ?? CustomActionButtonVariant.solid;
    final effectiveIsEnabled = isEnabled ?? true;
    final effectiveOnPressed = effectiveIsEnabled ? onPressed : null;

    switch (effectiveVariant) {
      case CustomActionButtonVariant.solid:
        return _buildSolidButton(effectiveOnPressed);
      case CustomActionButtonVariant.textOnly:
        return _buildTextOnlyButton(effectiveOnPressed);
    }
  }

  Widget _buildSolidButton(VoidCallback? onPressed) {
    return SizedBox(
      width: width ?? 87.h,
      height: height ?? 34.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Color(0xFFF3F4F6),
          foregroundColor: textColor ?? Color(0xFF374151),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17.h),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          text,
          style: TextStyleHelper.instance.body12MediumPoppins
              .copyWith(height: 1.5),
        ),
      ),
    );
  }

  Widget _buildTextOnlyButton(VoidCallback? onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? appTheme.whiteCustom,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          height: 1.5,
          decoration: TextDecoration.underline,
          decorationColor: textColor ?? appTheme.whiteCustom,
        ),
      ),
    );
  }
}

/// Enum defining the styling variants for CustomActionButton
enum CustomActionButtonVariant {
  /// Solid background button with rounded corners
  solid,

  /// Text-only button with underline decoration
  textOnly,
}
