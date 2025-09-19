import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_image_view_copy.dart';

class KycIdentityVerificationScreen extends StatelessWidget {
  const KycIdentityVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFF0908,
      body: Stack(
        children: [
          // Background Ellipse
          Positioned(
            top: 0,
            left: 43.h,
            child: CustomImageView(
              imagePath: ImageConstant.imgEllipse78435x386,
              height: 438.h,
              width: 386.h,
            ),
          ),

          // Main Content
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8.h, 27.h, 8.h, 0),
                child: Column(
                  children: [
                    // Custom App Bar
                    CustomAppBar(
                      title: 'KYC',
                      onBackPressed: () => Navigator.of(context).pop(), isAbsolutePositioned: true,
                    ),

                    SizedBox(height: 24.h),

                    // Main Content Card
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: appTheme.whiteCustom,
                        borderRadius: BorderRadius.circular(30.h),
                        border: Border.all(color: appTheme.whiteCustom),
                        boxShadow: [
                          BoxShadow(
                            color: appTheme.colorFF8888,
                            blurRadius: 54.h,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(24.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Card Header
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Verify Your Identity',
                                  style: TextStyleHelper
                                      .instance.headline24SemiBoldPoppins
                                      .copyWith(
                                          color: appTheme.blackCustom,
                                          height: 1.5),
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'Please upload a valid government-issued\nID to complete your verification-',
                                  style: TextStyleHelper
                                      .instance.body14RegularPoppins
                                      .copyWith(
                                          color: appTheme.colorFF6B72,
                                          height: 1.57),
                                ),
                              ],
                            ),

                            SizedBox(height: 24.h),

                            // Upload Section
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Upload Government ID:',
                                  style: TextStyleHelper
                                      .instance.body12MediumPoppins
                                      .copyWith(
                                          color: appTheme.colorFF1B19,
                                          height: 1.5),
                                ),
                                SizedBox(height: 12.h),

                                // File Upload Container
                                Container(
                                  height: 54.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: appTheme.colorFFF9FA,
                                    border:
                                        Border.all(color: appTheme.colorFFD1D5),
                                    borderRadius: BorderRadius.circular(16.h),
                                    boxShadow: [
                                      BoxShadow(
                                        color: appTheme.colorFF8888,
                                        blurRadius: 54.h,
                                        offset: Offset(0, 4.h),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      // File Input Display
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 16.h),
                                          child: Text(
                                            'Cover .PNG',
                                            style: TextStyleHelper
                                                .instance.body12MediumPoppins
                                                .copyWith(
                                                    color: appTheme.colorFF6B72,
                                                    height: 1.5),
                                          ),
                                        ),
                                      ),

                                      // Choose File Button
                                      Positioned(
                                        left: 20.h,
                                        top: 50.h / 2 - 17.h,
                                        child: GestureDetector(
                                          onTap: () {
                                            // Handle file selection
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: appTheme.colorFFF3F4,
                                              border: Border.all(
                                                  color: appTheme.colorFFD1D5),
                                              borderRadius:
                                                  BorderRadius.circular(8.h),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16.h,
                                              vertical: 6.h,
                                            ),
                                            child: Text(
                                              'Choose File',
                                              style: TextStyleHelper
                                                  .instance.body12MediumPoppins
                                                  .copyWith(height: 1.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 24.h),

                            // Document Preview
                            CustomImageView(
                              imagePath: ImageConstant
                                  .img190927plcyrealidlicensedcjpg1,
                              height: 227.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),

                            SizedBox(height: 32.h),

                            // Next Button
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    AppRoutes.kycIdentityVerificationScreenTwo);
                              },
                              child: Container(
                                width: double.infinity,
                                height: 60.h,
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
                                child: Center(
                                  child: Text(
                                    'Next',
                                    style: TextStyleHelper
                                        .instance.title16MediumPoppins
                                        .copyWith(height: 1.5),
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
            ),
          ),
        ],
      ),
    );
  }
}
