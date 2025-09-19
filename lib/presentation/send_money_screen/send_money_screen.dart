import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_action_button.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_image_view_copy.dart';

class SendMoneyScreen extends StatelessWidget {
  SendMoneyScreen({Key? key}) : super(key: key);

  TextEditingController amountController = TextEditingController(text: '\$43');
  TextEditingController noteController =
      TextEditingController(text: 'Note: Rent Playstation 5');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFF0908,
      body: Stack(
        children: [
          // Background ellipse decoration
          Positioned(
            top: 0,
            left: 43.h,
            child: CustomImageView(
              imagePath: ImageConstant.imgEllipse78435x386,
              height: 438.h,
              width: 386.h,
            ),
          ),

          // Main content
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 27.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Custom App Bar
                Container(
                  margin: EdgeInsets.only(left: 8.h, bottom: 24.h),
                  child: CustomAppBar(
                    title: 'Send Money',
                    onBackPressed: () {
                      Navigator.of(context).pop();
                    }, isAbsolutePositioned: false,
                  ),
                ),

                // Recipient Card
                Container(
                  height: 89.h,
                  width: 414.h,
                  decoration: BoxDecoration(
                    color: appTheme.whiteCustom,
                    borderRadius: BorderRadius.circular(20.h),
                    border: Border.all(color: appTheme.whiteCustom),
                    boxShadow: [
                      BoxShadow(
                        color: appTheme.colorFF8888,
                        offset: Offset(0, 4),
                        blurRadius: 54.h,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 16.h),
                  margin: EdgeInsets.only(bottom: 24.h),
                  child: Row(
                    children: [
                      // Profile Image
                      CustomImageView(
                        imagePath: ImageConstant.imgEllipse78,
                        height: 49.h,
                        width: 49.h,
                        fit: BoxFit.cover,
                      ),

                      SizedBox(width: 16.h),

                      // User Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Gladys',
                              style: TextStyleHelper
                                  .instance.title18MediumPoppins
                                  .copyWith(
                                      color: appTheme.blackCustom, height: 1.5),
                            ),
                            Text(
                              '**** **** 6252',
                              style: TextStyleHelper
                                  .instance.body14MediumPoppins
                                  .copyWith(
                                      color: appTheme.grey600, height: 1.5),
                            ),
                          ],
                        ),
                      ),

                      // Change Button
                      CustomActionButton(
                        text: 'Change',
                        onPressed: () {
                          // Handle change recipient
                        },
                        variant: CustomActionButtonVariant.solid,
                        backgroundColor: appTheme.colorFFF5F5,
                        textColor: appTheme.colorFF4B55,
                        width: 87.h,
                        height: 34.h,
                      ),
                    ],
                  ),
                ),

                // Amount Section
                Container(
                  height: 124.h,
                  width: 414.h,
                  decoration: BoxDecoration(
                    color: appTheme.whiteCustom,
                    borderRadius: BorderRadius.circular(24.h),
                    boxShadow: [
                      BoxShadow(
                        color: appTheme.colorFF8888,
                        offset: Offset(0, 4),
                        blurRadius: 54.h,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(bottom: 24.h),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120.h,
                          child: TextField(
                            controller: amountController,
                            textAlign: TextAlign.center,
                            style: TextStyleHelper
                                .instance.display48MediumPoppins
                                .copyWith(height: 1.5),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onChanged: (value) {
                              // Handle amount change
                            },
                          ),
                        ),
                        SizedBox(width: 16.h),
                        Container(
                          width: 2.h,
                          height: 40.h,
                          color: appTheme.colorFFD1D5,
                        ),
                      ],
                    ),
                  ),
                ),

                // Note Section
                Container(
                  height: 82.h,
                  width: 414.h,
                  decoration: BoxDecoration(
                    color: appTheme.whiteCustom,
                    borderRadius: BorderRadius.circular(20.h),
                    border: Border.all(color: appTheme.whiteCustom),
                    boxShadow: [
                      BoxShadow(
                        color: appTheme.colorFF8888,
                        offset: Offset(0, 4),
                        blurRadius: 54.h,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  margin: EdgeInsets.only(bottom: 24.h),
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgOutlineNotesDocument,
                        height: 24.h,
                        width: 24.h,
                      ),
                      SizedBox(width: 16.h),
                      Expanded(
                        child: TextField(
                          controller: noteController,
                          style: TextStyleHelper.instance.title16MediumPoppins
                              .copyWith(
                                  color: appTheme.blackCustom, height: 1.5),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          onChanged: (value) {
                            // Handle note change
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Continue Button
                Container(
                  height: 60.h,
                  width: 414.h,
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
                      Navigator.of(context)
                          .pushNamed(AppRoutes.paymentConfirmationScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appTheme.transparentCustom,
                      shadowColor: appTheme.transparentCustom,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.h),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyleHelper.instance.title16MediumPoppins
                          .copyWith(height: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
