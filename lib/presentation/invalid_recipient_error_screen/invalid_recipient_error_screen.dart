import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_image_view_copy.dart';

// Modified: Added dart:ui import for ImageFilter

class InvalidRecipientErrorScreen extends StatelessWidget {
  const InvalidRecipientErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.blackCustom,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // Modal Overlay
            Container(
              width: double.infinity,
              height: double.infinity,
              color: appTheme.blackCustom.withAlpha(128),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  color: appTheme.transparentCustom,
                ),
              ),
            ),

            // Error Dialog Modal
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.h),
                padding: EdgeInsets.all(32.h),
                width: double.infinity,
                constraints: BoxConstraints(maxWidth: 400.h),
                decoration: BoxDecoration(
                  color: appTheme.colorFF1B19,
                  border: Border.all(color: appTheme.whiteCustom, width: 1.h),
                  borderRadius: BorderRadius.circular(24.h),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Error Icon Container
                    Container(
                      width: 84.h,
                      height: 84.h,
                      margin: EdgeInsets.only(bottom: 24.h),
                      decoration: BoxDecoration(
                        color: appTheme.whiteCustom,
                        border:
                            Border.all(color: appTheme.whiteCustom, width: 1.h),
                        borderRadius: BorderRadius.circular(42.h),
                      ),
                      child: Center(
                        child: CustomImageView(
                          imagePath: ImageConstant.imgBoldUsersUserBlock,
                          height: 40.h,
                          width: 40.h,
                        ),
                      ),
                    ),

                    // Error Title
                    Text(
                      'Invalid Recipient',
                      style: TextStyleHelper.instance.headline24SemiBoldPoppins
                          .copyWith(height: 1.54),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 16.h),

                    // Error Description
                    Container(
                      constraints: BoxConstraints(maxWidth: 332.h),
                      child: Text(
                        'Please check the recipient details and try again',
                        style: TextStyleHelper.instance.body14RegularPoppins
                            .copyWith(height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Try Again Button
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 60.h,
                        constraints: BoxConstraints(maxWidth: 350.h),
                        decoration: BoxDecoration(
                          color: appTheme.whiteCustom,
                          borderRadius: BorderRadius.circular(30.h),
                        ),
                        child: Center(
                          child: Text(
                            'Try Again',
                            style: TextStyleHelper.instance.title16MediumPoppins
                                .copyWith(
                                    color: appTheme.blackCustom, height: 1.5),
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
      ),
    );
  }
}
