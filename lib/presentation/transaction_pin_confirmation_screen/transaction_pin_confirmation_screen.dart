import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_action_button.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_image_view_copy.dart';

class TransactionPinConfirmationScreen extends StatelessWidget {
  TransactionPinConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFF0908,
      body: Container(
        height: 884.h,
        width: 430.h,
        child: Stack(
          children: [
            // Background Ellipse
            Positioned(
              top: 48.h,
              left: 44.h,
              child: CustomImageView(
                imagePath: ImageConstant.imgEllipse78,
                height: 435.h,
                width: 386.h,
              ),
            ),

            // App Bar
            Positioned(
              top: 75.h,
              left: 16.h,
              child: CustomAppBar(
                onBackPressed: () => Navigator.of(context).pop(),
                isAbsolutePositioned: true,
              ),
            ),

            // Main Content
            Positioned(
              top: 163.h,
              left: 8.h,
              child: Container(
                width: 414.h,
                height: 278.h,
                child: Column(
                  children: [
                    // Title
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 58.h),
                      margin: EdgeInsets.only(bottom: 20.h),
                      child: Text(
                        'Confirm Transaction PIN',
                        style: TextStyleHelper
                            .instance.headline24SemiBoldPoppins
                            .copyWith(height: 1.5),
                        textAlign: TextAlign.left,
                      ),
                    ),

                    // OTP/PIN Input
                    Container(
                      margin: EdgeInsets.only(bottom: 32.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildPinDigit('5', true),
                          SizedBox(width: 12.h),
                          _buildPinDigit('2', true),
                          SizedBox(width: 12.h),
                          _buildPinDigit('', false, showLine: true),
                          SizedBox(width: 12.h),
                          _buildPinDigit('', false),
                        ],
                      ),
                    ),

                    // Continue Button
                    Container(
                      margin: EdgeInsets.only(bottom: 34.h),
                      child: CustomActionButton(
                        text: 'Continue',
                        onPressed: () => _handleContinue(context),
                        variant: CustomActionButtonVariant.solid,
                        width: 414.h,
                        height: 60.h,
                      ),
                    ),

                    // Biometrics Link
                    Center(
                      child: CustomActionButton(
                        text: 'Biometrics',
                        onPressed: () => _handleBiometrics(context),
                        variant: CustomActionButtonVariant.textOnly,
                        textColor: appTheme.whiteCustom,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinDigit(String digit, bool isFilled, {bool showLine = false}) {
    return Container(
      height: 72.h,
      width: 72.h,
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(color: appTheme.whiteCustom),
        gradient: isFilled
            ? LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFFBE7A85), Color(0xFF3418A1)],
              )
            : null,
      ),
      child: Center(
        child: showLine
            ? Container(
                height: 2.h,
                width: 26.h,
                color: appTheme.whiteCustom,
              )
            : (digit.isNotEmpty
                ? Text(
                    digit,
                    style: TextStyleHelper.instance.headline24SemiBoldPoppins,
                  )
                : SizedBox()),
      ),
    );
  }

  void _handleContinue(BuildContext context) {
    // Handle PIN validation and continuation logic
  }

  void _handleBiometrics(BuildContext context) {
    // Handle biometric authentication logic
  }
}
