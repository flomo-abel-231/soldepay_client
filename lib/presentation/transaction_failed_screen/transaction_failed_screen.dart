import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_image_view_copy.dart';

class TransactionFailedScreen extends StatelessWidget {
  TransactionFailedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.blackCustom,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // Modal Overlay Background
            Container(
              width: double.infinity,
              height: double.infinity,
              color: appTheme.blackCustom.withAlpha(128),
            ),

            // Modal Container
            Center(
              child: Container(
                margin: EdgeInsets.all(16.h),
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
                      decoration: BoxDecoration(
                        color: appTheme.color19ED3E,
                        border:
                            Border.all(color: appTheme.whiteCustom, width: 1.h),
                        borderRadius: BorderRadius.circular(42.h),
                      ),
                      child: Center(
                        child: CustomImageView(
                          imagePath: ImageConstant.imgNomoney2,
                          width: 39.h,
                          height: 32.h,
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Title
                    Text(
                      'Transaction Failed',
                      style: TextStyleHelper.instance.headline24SemiBoldPoppins
                          .copyWith(height: 1.54),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 16.h),

                    // Description
                    Text(
                      'Something went wrong. Please try again',
                      style: TextStyleHelper.instance.body14RegularPoppins
                          .copyWith(height: 1.5),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 32.h),

                    // Try Again Button
                    GestureDetector(
                      onTap: _handleRetryTransaction,
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

  void _handleRetryTransaction() {
    // Handle retry transaction logic
    // This would typically navigate back to payment flow or retry the failed transaction
  }
}
