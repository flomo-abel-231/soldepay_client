import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_image_view.dart';
import './widgets/pin_digit_widget.dart';

class PinEntryScreen extends StatefulWidget {
  @override
  _PinEntryScreenState createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen> {
  List<String> pinDigits = ['7', '8', '', ''];
  int currentIndex = 2;

  void handlePinInput(String value) {
    if (currentIndex < 4 && value.isNotEmpty) {
      setState(() {
        pinDigits[currentIndex] = value;
        if (currentIndex < 3) {
          currentIndex++;
        }
      });
    }
  }

  void handleBackNavigation() {
    Navigator.of(context).pop();
  }

  void handleConfirmPin() {
    String pin = pinDigits.join();
    if (pin.length == 4) {
      // Handle PIN confirmation logic
      print('PIN confirmed: $pin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFF0908,
      body: Stack(
        children: [
          // Background decoration
          Positioned(
            top: 0,
            left: 44.h,
            child: CustomImageView(
              imagePath: ImageConstant.imgEllipse78435x386,
              height: 435.h,
              width: 386.h,
            ),
          ),

          // App Bar
          Positioned(
            top: 27.h,
            left: 16.h,
            child: GestureDetector(
              onTap: handleBackNavigation,
              child: Container(
                width: 56.h,
                height: 56.h,
                decoration: BoxDecoration(
                  color: appTheme.whiteCustom,
                  borderRadius: BorderRadius.circular(28.h),
                ),
                child: Center(
                  child: CustomImageView(
                    imagePath: ImageConstant.imgArrowleft,
                    height: 24.h,
                    width: 24.h,
                  ),
                ),
              ),
            ),
          ),

          // Main content
          Positioned(
            top: 107.h,
            left: 8.h,
            child: Container(
              width: 414.h,
              child: Column(
                children: [
                  // Title
                  Text(
                    'Enter pin',
                    style: TextStyleHelper.instance.headline24SemiBold,
                  ),

                  SizedBox(height: 26.h),

                  // PIN input row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 4; i++) ...[
                        PinDigitWidget(
                          value: pinDigits[i],
                          isActive: i == currentIndex,
                          isFilled: pinDigits[i].isNotEmpty,
                        ),
                        if (i < 3) SizedBox(width: 12.h),
                      ],
                    ],
                  ),

                  SizedBox(height: 32.h),

                  // Confirm button
                  GestureDetector(
                    onTap: handleConfirmPin,
                    child: Container(
                      width: 414.h,
                      height: 60.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFBE7A85), Color(0xFF3418A1)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.h),
                      ),
                      child: Center(
                        child: Text(
                          'Confirm',
                          style: TextStyleHelper.instance.title16Medium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
