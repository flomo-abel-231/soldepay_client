import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';

class PaymentsOnboardingScreen extends StatelessWidget {
  PaymentsOnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFF0908,
      body: Container(
        height: 884.h,
        width: 430.h,
        child: Column(
          children: [
            SizedBox(height: 48.h),
            _buildIllustrationSection(),
            SizedBox(height: 64.h),
            _buildMainHeading(),
            SizedBox(height: 16.h),
            _buildDescriptionText(),
            SizedBox(height: 48.h),
            _buildGetStartedButton(),
            SizedBox(height: 64.h),
            _buildPageIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildIllustrationSection() {
    return Container(
      height: 453.h,
      width: 414.h,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 27.h,
            child: CustomImageView(
              imagePath: ImageConstant.imgEllipse78,
              height: 438.h,
              width: 386.h,
            ),
          ),
          Positioned(
            top: 74.h,
            left: 0,
            child: CustomImageView(
              imagePath: ImageConstant.img931977041369441,
              height: 379.h,
              width: 398.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainHeading() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 48.h),
      child: Text(
        'Secure, Fast & Easy Digital Payments',
        textAlign: TextAlign.center,
        style: TextStyleHelper.instance.headline34SemiBoldPoppins
            .copyWith(height: 1.29),
      ),
    );
  }

  Widget _buildDescriptionText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 64.h),
      child: Text(
        'Unlock fast, secure payments and manage your finances',
        textAlign: TextAlign.center,
        style: TextStyleHelper.instance.title16RegularPoppins
            .copyWith(height: 1.5),
      ),
    );
  }

  Widget _buildGetStartedButton() {
    return CustomButton(
      text: 'Get Started',
      buttonType: CustomButtonType.gradient,
      width: 398.h,
      height: 53.h,
      borderRadius: 26,
      onPressed: () => _handleGetStarted(),
    );
  }

  Widget _buildPageIndicator() {
    return CustomImageView(
      imagePath: ImageConstant.imgGroup1597885172,
      height: 6.h,
      width: 41.h,
    );
  }

  void _handleGetStarted() {
    // Handle get started button click
    // Add navigation logic here if needed
  }
}
