import 'package:flutter/material.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

/**
 * CustomButton - A flexible, reusable button component that supports multiple variants
 * including text-only, icon+text, and gradient background buttons.
 * 
 * @param text - The button text content
 * @param onPressed - Callback function when button is pressed
 * @param buttonType - Type of button styling (text, outlined, gradient)
 * @param width - Button width
 * @param height - Button height  
 * @param iconPath - Optional icon image path
 * @param backgroundColor - Background color for solid buttons
 * @param borderColor - Border color for outlined buttons
 * @param textColor - Text color
 * @param borderRadius - Button border radius
 * @param fontSize - Text font size
 * @param fontWeight - Text font weight
 * @param gradientColors - List of colors for gradient background
 * @param isEnabled - Whether button is enabled or disabled
 */
class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.buttonType = CustomButtonType.text,
    this.width,
    this.height,
    this.iconPath,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.gradientColors,
    this.isEnabled = true,
  }) : super(key: key);

  /// The text displayed on the button
  final String text;

  /// Callback function triggered when button is pressed
  final VoidCallback? onPressed;

  /// Type of button styling
  final CustomButtonType buttonType;

  /// Button width
  final double? width;

  /// Button height
  final double? height;

  /// Optional icon image path
  final String? iconPath;

  /// Background color for solid buttons
  final Color? backgroundColor;

  /// Border color for outlined buttons
  final Color? borderColor;

  /// Text color
  final Color? textColor;

  /// Button border radius
  final double? borderRadius;

  /// Text font size
  final double? fontSize;

  /// Text font weight
  final FontWeight? fontWeight;

  /// List of colors for gradient background
  final List<Color>? gradientColors;

  /// Whether button is enabled or disabled
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 53.h,
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    switch (buttonType) {
      case CustomButtonType.text:
        return _buildTextButton();
      case CustomButtonType.outlined:
        return _buildOutlinedButton();
      case CustomButtonType.gradient:
        return _buildGradientButton();
      default:
        return _buildTextButton();
    }
  }

  Widget _buildTextButton() {
    return TextButton(
      onPressed: isEnabled ? onPressed : null,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor ?? appTheme.transparentCustom,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.h),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
      ),
      child: _buildButtonContent(),
    );
  }

  Widget _buildOutlinedButton() {
    return OutlinedButton(
      onPressed: isEnabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor ?? appTheme.transparentCustom,
        side: BorderSide(
          color: borderColor ?? appTheme.whiteCustom,
          width: 1.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 32.h),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
      ),
      child: _buildButtonContent(),
    );
  }

  Widget _buildGradientButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: gradientColors ??
              [
                Color(0xFFBE7A85),
                appTheme.colorFF3418,
              ],
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 26.h),
      ),
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.transparentCustom,
          shadowColor: appTheme.transparentCustom,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 26.h),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
        ),
        child: _buildButtonContent(),
      ),
    );
  }

  Widget _buildButtonContent() {
    final defaultTextColor = _getDefaultTextColor();
    final defaultFontSize = _getDefaultFontSize();
    final defaultFontWeight = _getDefaultFontWeight();

    if (iconPath != null && iconPath!.isNotEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: iconPath!,
            height: 21.h,
            width: 21.h,
          ),
          SizedBox(width: 12.h),
          Text(
            text,
            style: TextStyleHelper.instance.title16Poppins.copyWith(
                color: textColor ?? defaultTextColor,
                fontSize: (fontSize ?? defaultFontSize)),
          ),
        ],
      );
    }

    return Text(
      text,
      style: TextStyleHelper.instance.title16Poppins.copyWith(
          color: textColor ?? defaultTextColor,
          fontSize: (fontSize ?? defaultFontSize)),
    );
  }

  Color _getDefaultTextColor() {
    switch (buttonType) {
      case CustomButtonType.text:
      case CustomButtonType.outlined:
      case CustomButtonType.gradient:
        return appTheme.whiteCustom;
      default:
        return appTheme.whiteCustom;
    }
  }

  double _getDefaultFontSize() {
    switch (buttonType) {
      case CustomButtonType.text:
        return 14;
      case CustomButtonType.outlined:
      case CustomButtonType.gradient:
        return 16;
      default:
        return 16;
    }
  }

  FontWeight _getDefaultFontWeight() {
    switch (buttonType) {
      case CustomButtonType.text:
        return FontWeight.w600;
      case CustomButtonType.outlined:
      case CustomButtonType.gradient:
        return FontWeight.w500;
      default:
        return FontWeight.w500;
    }
  }
}

/// Enum for different button types
enum CustomButtonType {
  text,
  outlined,
  gradient,
}
