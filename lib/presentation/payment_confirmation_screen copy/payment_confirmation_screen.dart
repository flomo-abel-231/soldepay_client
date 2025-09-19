import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_image_view_copy.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  PaymentConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFF0908,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
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
                fit: BoxFit.cover,
              ),
            ),

            // Main Content
            Column(
              children: [
                // Custom App Bar
                CustomAppBar(
                  title: 'Confirm Payment',
                  onBackPressed: () {
                    Navigator.of(context).pop();
                  }, isAbsolutePositioned: false,
                ),
        

                // Success Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Column(
                        children: [
                          SizedBox(height: 32.h),

                          // Success Icon
                          CustomImageView(
                            imagePath: ImageConstant.imgGroup67,
                            height: 177.h,
                            width: 175.h,
                          ),

                          SizedBox(height: 32.h),

                          // Success Message
                          Container(
                            constraints: BoxConstraints(maxWidth: 275.h),
                            child: Text(
                              'Payment successful! Your balance has been updated.',
                              textAlign: TextAlign.center,
                              style: TextStyleHelper
                                  .instance.title16RegularPoppins
                                  .copyWith(height: 1.5),
                            ),
                          ),

                          SizedBox(height: 24.h),

                          // Amount Display
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$',
                                style: TextStyleHelper
                                    .instance.display36BoldPoppins
                                    .copyWith(height: 1.47),
                              ),
                              Text(
                                '730.00',
                                style: TextStyleHelper
                                    .instance.display36BoldPoppins
                                    .copyWith(height: 1.47),
                              ),
                            ],
                          ),

                          SizedBox(height: 32.h),

                          // Details Section
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: appTheme.whiteCustom,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24.h),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: appTheme.colorFF8888,
                                  blurRadius: 54,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              border: Border.all(color: appTheme.whiteCustom),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.h,
                              vertical: 16.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Details',
                                  style: TextStyleHelper
                                      .instance.title18MediumPoppins
                                      .copyWith(height: 1.39),
                                ),

                                SizedBox(height: 16.h),

                                Container(
                                  height: 1.h,
                                  color: appTheme.whiteCustom,
                                ),

                                SizedBox(height: 20.h),

                                // Transaction Details
                                _buildDetailRow('Updates balance', '\$1550,00'),
                                SizedBox(height: 20.h),
                                _buildDetailRow(
                                    'Transcription ID', 'AWEfa774AA232a'),
                                SizedBox(height: 20.h),
                                _buildDetailRow(
                                    'Transactions Date', 'Jun 7, 2025'),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // Done Button
                          Container(
                            width: double.infinity,
                            height: 60.h,
                            margin: EdgeInsets.symmetric(horizontal: 8.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.h),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFFBE7A85),
                                  appTheme.colorFF3418,
                                ],
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle done button click
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appTheme.transparentCustom,
                                shadowColor: appTheme.transparentCustom,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.h),
                                ),
                              ),
                              child: Text(
                                'Done',
                                style: TextStyleHelper
                                    .instance.title16MediumPoppins
                                    .copyWith(height: 1.5),
                              ),
                            ),
                          ),

                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyleHelper.instance.body14RegularPoppins
              .copyWith(height: 1.43),
        ),
        Text(
          value,
          style: TextStyleHelper.instance.body14SemiBoldPoppins
              .copyWith(height: 1.43),
        ),
      ],
    );
  }
}
