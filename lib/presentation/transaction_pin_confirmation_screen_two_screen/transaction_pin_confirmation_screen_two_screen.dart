import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_action_button.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_image_view_copy.dart';

class TransactionPinConfirmationScreenTwo extends StatelessWidget {
  TransactionPinConfirmationScreenTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFF0908,
      body: SizedBox(
        height: 884.h,
        width: 430.h,
        child: Stack(
          children: [
            // Background Ellipse
            Positioned(
              top: 0,
              left: 44.h,
              child: CustomImageView(
                imagePath: ImageConstant.imgEllipse78,
                height: 435.h,
                width: 386.h,
                fit: BoxFit.cover,
              ),
            ),

            // App Bar
            Positioned(
              top: 27.h,
              left: 16.h,
              child: CustomAppBar(
                onBackPressed: () {
                  Navigator.of(context).pop();
                },
                isAbsolutePositioned: true,
              ),
            ),

            // Main Content
            Positioned(
              top: 115.h,
              left: 8.h,
              child: SizedBox(
                width: 414.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 58.h),
                      child: Text(
                        'Confirm Transaction PIN',
                        style: TextStyleHelper.instance.headline24SemiBold
                            .copyWith(height: 1.5),
                        textAlign: TextAlign.left,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // PIN Input Fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildPinDigit('5', true),
                        SizedBox(width: 12.h),
                        _buildPinDigit('2', true),
                        SizedBox(width: 12.h),
                        _buildPinDigit('', false, showDash: true),
                        SizedBox(width: 12.h),
                        _buildPinDigit('', false),
                      ],
                    ),

                    SizedBox(height: 32.h),

                    // Continue Button
                    Container(
                      height: 60.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFFBE7A85),
                            appTheme.colorFF3418,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30.h),
                      ),
                      child: Material(
                        color: appTheme.transparentCustom,
                        child: InkWell(
                          onTap: () {
                            // Handle continue action
                          },
                          borderRadius: BorderRadius.circular(30.h),
                          child: Center(
                            child: Text(
                              'Continue',
                              style: TextStyleHelper.instance.title16Medium,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 34.h),

                    // Biometrics Button
                    Center(
                      child: CustomActionButton(
                        text: 'Biometrics',
                        onPressed: () {
                          // Handle biometric authentication
                        },
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

  Widget _buildPinDigit(String digit, bool filled, {bool showDash = false}) {
    return Container(
      height: 72.h,
      width: 72.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.h),
        border: filled
            ? Border.all(
                width: 1.h,
                color: appTheme.transparentCustom,
              )
            : Border.all(
                width: 1.h,
                color: appTheme.whiteCustom,
              ),
        gradient: filled
            ? LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFFBE7A85),
                  appTheme.colorFF3418,
                ],
              )
            : null,
      ),
      child: Center(
        child: filled
            ? Text(
                digit,
                style: TextStyleHelper.instance.headline24SemiBold,
              )
            : showDash
                ? Container(
                    height: 2.h,
                    width: 26.h,
                    color: appTheme.whiteCustom,
                  )
                : null,
      ),
    );
  }
}
