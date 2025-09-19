import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({Key? key}) : super(key: key);

  final List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  @override
  Widget build(BuildContext context) {
    // Initialize some OTP values as shown in the design
    otpControllers[0].text = '5';
    otpControllers[1].text = '0';
    otpControllers[2].text = '7';
    otpControllers[3].text = '8';

    return Scaffold(
      backgroundColor: appTheme.colorFF0908,
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            // Background decoration
            Positioned(
              top: 48.h,
              left: 44.h,
              child: CustomImageView(
                imagePath: ImageConstant.imgEllipse78435x386,
                height: 435.h,
                width: 386.h,
              ),
            ),

            // App Bar
            Positioned(
              top: 75.h,
              left: 16.h,
              child: CustomAppBar(
                onBackPressed: () => Navigator.of(context).pop(), isAbsolutePositioned: false,
              ),
            ),

            // Main Content
            Positioned(
              top: 155.h,
              left: 8.h,
              child: SizedBox(
                width: 414.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      'OTP Verification',
                      style: TextStyleHelper.instance.headline24SemiBold
                          .copyWith(height: 1.5),
                    ),

                    SizedBox(height: 12.h),

                    // Instruction text
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Text(
                        'Enter the 6-degit code send to Eaxmple@gmail.com',
                        style: TextStyleHelper.instance.body14Regular
                            .copyWith(height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 25.h),

                    // OTP Input Fields
                    _buildOtpFields(),

                    SizedBox(height: 31.h),

                    // Verification Button
                    CustomButton(
                      text: 'Verification',
                      buttonType: CustomButtonType.gradient,
                      width: 414.h,
                      height: 60.h,
                      borderRadius: 30,
                      onPressed: () => _handleVerification(),
                    ),

                    SizedBox(height: 12.h),

                    // Resend code text
                    _buildResendText(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Container(
          margin: EdgeInsets.only(right: index < 5 ? 12.h : 0),
          child: _buildOtpField(index),
        );
      }),
    );
  }

  Widget _buildOtpField(int index) {
    // Special styling for the 5th field (index 4) - shows a line
    if (index == 4) {
      return Container(
        height: 53.h,
        width: 53.h,
        decoration: BoxDecoration(
          color: appTheme.whiteCustom,
          borderRadius: BorderRadius.circular(12.h),
          border: Border.all(color: appTheme.whiteCustom, width: 1.h),
        ),
        child: Center(
          child: Container(
            height: 2.h,
            width: 26.h,
            color: appTheme.whiteCustom,
          ),
        ),
      );
    }

    // Special styling for the 6th field (index 5) - different border radius
    bool isLastField = index == 5;
    bool hasGradientBorder = index < 4;

    return Container(
      height: 53.h,
      width: 53.h,
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        borderRadius: BorderRadius.circular(isLastField ? 8.h : 12.h),
        border: hasGradientBorder
            ? null
            : Border.all(color: appTheme.whiteCustom, width: 1.h),
        gradient: hasGradientBorder
            ? LinearGradient(
                colors: [Color(0xFFBE7A85), Color(0xFF3418A1)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
      ),
      child: Container(
        margin: hasGradientBorder ? EdgeInsets.all(1.h) : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: appTheme.whiteCustom,
          borderRadius: BorderRadius.circular(isLastField ? 7.h : 11.h),
        ),
        child: TextFormField(
          controller: otpControllers[index],
          focusNode: focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: TextStyleHelper.instance.title20Medium,
          decoration: InputDecoration(
            counterText: '',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) => _handleOtpInput(value, index),
        ),
      ),
    );
  }

  Widget _buildResendText() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Didn\'t receive code?',
            style:
                TextStyleHelper.instance.body14Regular.copyWith(height: 1.36),
          ),
          TextSpan(
            text: ' Resend',
            style: TextStyleHelper.instance.body14Medium.copyWith(height: 1.36),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  void _handleOtpInput(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      // Move to next field
      focusNodes[index + 1].requestFocus();
    }
  }

  void _handleVerification() {
    String otp = otpControllers.map((controller) => controller.text).join();
    print('Verifying OTP: $otp');
    // Add verification logic here
  }
}
