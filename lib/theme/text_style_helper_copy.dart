import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A helper class for managing text styles in the application
class TextStyleHelper {
  static TextStyleHelper? _instance;

  TextStyleHelper._();

  static TextStyleHelper get instance {
    _instance ??= TextStyleHelper._();
    return _instance!;
  }

  // Display Styles
  // Large text styles typically used for headers and hero elements

  TextStyle get display48MediumPoppins => TextStyle(
        fontSize: 48.fSize,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
        color: appTheme.blackCustom,
      );

  TextStyle get display40Bold => TextStyle(
        fontSize: 40.fSize,
        fontWeight: FontWeight.w700,
        color: appTheme.whiteCustom,
      );

  TextStyle get display36BoldPoppins => TextStyle(
        fontSize: 36.fSize,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
        color: appTheme.whiteCustom,
      );

  // Headline Styles
  // Medium-large text styles for section headers

  TextStyle get headline26BoldHelveticaNowDisplay => TextStyle(
        fontSize: 26.fSize,
        fontWeight: FontWeight.bold,
        fontFamily: 'Helvetica Now Display',
        color: appTheme.whiteCustom,
      );

  TextStyle get headline24SemiBoldPoppins => TextStyle(
        fontSize: 24.fSize,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
        color: appTheme.whiteCustom,
      );

  TextStyle get headline24SemiBold => TextStyle(
        fontSize: 24.fSize,
        fontWeight: FontWeight.w600,
        color: appTheme.whiteCustom,
      );

  // Title Styles
  // Medium text styles for titles and subtitles

  TextStyle get title20RegularRoboto => TextStyle(
        fontSize: 20.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      );

  TextStyle get title18SemiBoldPoppins => TextStyle(
        fontSize: 18.fSize,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
        color: appTheme.whiteCustom,
      );

  TextStyle get title18MediumPoppins => TextStyle(
        fontSize: 18.fSize,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
        color: appTheme.whiteCustom,
      );

  TextStyle get title18SemiBold => TextStyle(
        fontSize: 18.fSize,
        fontWeight: FontWeight.w600,
        color: appTheme.whiteCustom,
      );

  TextStyle get title18Medium => TextStyle(
        fontSize: 18.fSize,
        fontWeight: FontWeight.w500,
        color: appTheme.blackCustom,
      );

  TextStyle get title16Poppins => TextStyle(
        fontSize: 16.fSize,
        fontFamily: 'Poppins',
        color: appTheme.whiteCustom,
      );

  TextStyle get title16MediumLufga => TextStyle(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
        fontFamily: 'Lufga',
        color: appTheme.whiteCustom,
      );

  TextStyle get title16Lufga => TextStyle(
        fontSize: 16.fSize,
        fontFamily: 'Lufga',
        color: appTheme.whiteCustom,
      );

  TextStyle get title16MediumPoppins => TextStyle(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
        color: appTheme.whiteCustom,
      );

  TextStyle get title16Regular => TextStyle(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w400,
        color: appTheme.whiteCustom,
      );

  TextStyle get title16Medium => TextStyle(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
        color: appTheme.whiteCustom,
      );

  TextStyle get title16RegularPoppins => TextStyle(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins',
        color: appTheme.whiteCustom,
      );

  // Body Styles
  // Standard text styles for body content

  TextStyle get body14MediumPoppins => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
        color: appTheme.whiteCustom,
      );

  TextStyle get body14RegularPoppins => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins',
        color: appTheme.whiteCustom,
      );

  TextStyle get body14SemiBoldPoppins => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
        color: appTheme.whiteCustom,
      );

  TextStyle get body14Regular => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w400,
        color: appTheme.colorFF6B72,
      );

  TextStyle get body14SemiBold => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
        color: appTheme.blackCustom,
      );

  TextStyle get body12MediumPoppins => TextStyle(
        fontSize: 12.fSize,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
        color: appTheme.colorFF3741,
      );

  TextStyle get body12Medium => TextStyle(
        fontSize: 12.fSize,
        fontWeight: FontWeight.w500,
        color: appTheme.colorFF6B72,
      );
}
