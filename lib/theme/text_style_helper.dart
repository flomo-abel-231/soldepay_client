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

  TextStyle get display40BoldPoppins => TextStyle(
    fontSize: 40.fSize,
    fontWeight: FontWeight.w700,
    fontFamily: 'Poppins',
    color: appTheme.colorFF24F0,
  );

  // Headline Styles
  // Medium-large text styles for section headers

  TextStyle get headline34SemiBoldPoppins => TextStyle(
    fontSize: 34.fSize,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
    color: appTheme.whiteCustom,
  );

  TextStyle get headline34MediumPoppins => TextStyle(
    fontSize: 34.fSize,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: appTheme.whiteCustom,
  );

  TextStyle get headline26BoldPoppins => TextStyle(
    fontSize: 26.fSize,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
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

  TextStyle get title20Medium => TextStyle(
    fontSize: 20.fSize,
    fontWeight: FontWeight.w500,
    color: appTheme.blackCustom,
  );

  TextStyle get title18SemiBoldPoppins => TextStyle(
    fontSize: 18.fSize,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
    color: appTheme.whiteCustom,
  );

  TextStyle get title18SemiBold => TextStyle(
    fontSize: 18.fSize,
    fontWeight: FontWeight.w600,
    color: appTheme.whiteCustom,
  );

  TextStyle get title18MediumPoppins => TextStyle(
    fontSize: 18.fSize,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: appTheme.whiteCustom,
  );

  TextStyle get title18Medium =>
      TextStyle(fontSize: 18.fSize, fontWeight: FontWeight.w500);

  TextStyle get title16Poppins => TextStyle(
    fontSize: 16.fSize,
    fontFamily: 'Poppins',
    color: appTheme.whiteCustom,
  );

  TextStyle get title16MediumPoppins => TextStyle(
    fontSize: 16.fSize,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: appTheme.whiteCustom,
  );

  TextStyle get title16BoldPoppins => TextStyle(
    fontSize: 16.fSize,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
    color: appTheme.whiteCustom,
  );

  TextStyle get title16Regular => TextStyle(
    fontSize: 16.fSize,
    fontWeight: FontWeight.w400,
    color: appTheme.colorFF6B72,
  );

  TextStyle get title16RegularPoppins => TextStyle(
    fontSize: 16.fSize,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
    color: appTheme.whiteCustom,
  );

  TextStyle get title16Medium => TextStyle(
    fontSize: 16.fSize,
    fontWeight: FontWeight.w500,
    color: appTheme.whiteCustom,
  );

  TextStyle get title16Bold => TextStyle(
    fontSize: 16.fSize,
    fontWeight: FontWeight.bold,
    color: appTheme.colorFF0A08,
  );

  // Body Styles
  // Standard text styles for body content

  TextStyle get body14SemiBoldPoppins => TextStyle(
    fontSize: 14.fSize,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
    color: appTheme.whiteCustom,
  );

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

  TextStyle get body14Regular => TextStyle(
    fontSize: 14.fSize,
    fontWeight: FontWeight.w400,
    color: appTheme.whiteCustom,
  );

  TextStyle get body14SemiBold => TextStyle(
    fontSize: 14.fSize,
    fontWeight: FontWeight.w600,
    color: appTheme.whiteCustom,
  );

  TextStyle get body14Medium => TextStyle(
    fontSize: 14.fSize,
    fontWeight: FontWeight.w500,
    color: appTheme.whiteCustom,
  );

  TextStyle get body12MediumPoppins => TextStyle(
    fontSize: 12.fSize,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: appTheme.colorFFA5A9,
  );

  TextStyle get body12RegularPoppins => TextStyle(
    fontSize: 12.fSize,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
    color: appTheme.whiteCustom,
  );

  // Other Styles
  // Miscellaneous text styles without specified font size

  TextStyle get bodyTextPoppins => TextStyle(fontFamily: 'Poppins');

  get headline26BoldHelveticaNowDisplay => null;

  get title16MediumLufga => null;

  get title16Lufga => null;

  get display36BoldPoppins => null;

  get display40Bold => null;

  get body12Medium => null;

  get body14 => null;

  get display36SemiBold => null;
}
