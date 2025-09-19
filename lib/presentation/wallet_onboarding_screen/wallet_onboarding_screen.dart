import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';

class WalletOnboardingScreen extends StatelessWidget {
  const WalletOnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFF0908,
      body: SizedBox(
        height: 884.h,
        width: 430.h,
        child: Stack(
          children: [
            _buildCardStackSection(),
            _buildContentSection(context),
            _buildPageIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardStackSection() {
    return SizedBox(
      height: 754.h,
      width: 430.h,
      child: Stack(
        children: [
          _buildLeftCardSection(),
          _buildRightCardSection(),
        ],
      ),
    );
  }

  Widget _buildLeftCardSection() {
    return Positioned(
      top: 0,
      left: 43.h,
      child: Container(
        height: 438.h,
        width: 386.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.imgEllipse78),
            fit: BoxFit.cover,
          ),
        ),
        child: Positioned(
          top: 96.h,
          left: 48.h,
          child: _buildMainCard(),
        ),
      ),
    );
  }

  Widget _buildMainCard() {
    return Container(
      height: 340.h,
      width: 338.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.h),
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Color(0xFFBE7A85), Color(0xFF3418A1)],
        ),
      ),
      child: Stack(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle4317,
            height: 340.h,
            width: 338.h,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 27.h,
            left: 27.h,
            child: SizedBox(
              height: 288.h,
              width: 311.h,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgArrowright,
                      height: 69.h,
                      width: 92.h,
                    ),
                  ),
                  Positioned(
                    bottom: 44.h,
                    right: 0,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgMastercard,
                      height: 42.h,
                      width: 32.h,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: _buildCardDetails(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardDetails() {
    return SizedBox(
      height: 142.h,
      width: 185.h,
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgGroup,
            height: 46.h,
            width: 48.h,
          ),
          SizedBox(width: 8.h),
          SizedBox(
            height: 126.h,
            width: 128.h,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Text(
                    '5414 5424 2542 5421',
                    style: TextStyleHelper.instance.body14SemiBoldPoppins
                        .copyWith(height: 1.57),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 16.h,
                  child: Text(
                    'Exp 11/30',
                    style: TextStyleHelper.instance.body12RegularPoppins
                        .copyWith(height: 1.67),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightCardSection() {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        height: 538.h,
        width: 430.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.imgVector4),
            fit: BoxFit.cover,
          ),
        ),
        child: Positioned(
          top: 155.h,
          left: 30.h,
          child: _buildSecondaryCard(),
        ),
      ),
    );
  }

  Widget _buildSecondaryCard() {
    return Container(
      height: 184.h,
      width: 333.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.h),
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Color(0xFFBE7A85), Color(0xFF3418A1)],
        ),
      ),
      child: Stack(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle4317184x333,
            height: 184.h,
            width: 333.h,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 19.h,
            left: 19.h,
            child: SizedBox(
              height: 147.h,
              width: 294.h,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgGroup,
                        height: 29.h,
                        width: 37.h,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgArrowright,
                        height: 14.h,
                        width: 101.h,
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgMastercardYellow800,
                      height: 24.h,
                      width: 40.h,
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

  Widget _buildContentSection(BuildContext context) {
    return Positioned(
      bottom: 82.h,
      left: 16.h,
      child: SizedBox(
        height: 225.h,
        width: 398.h,
        child: Column(
          children: [
            Text(
              'Top-up & manage\nyour wallet seamlessly',
              textAlign: TextAlign.center,
              style: TextStyleHelper.instance.headline34MediumPoppins
                  .copyWith(height: 1.29),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 34.h),
              child: Text(
                'Top up your wallet instantly and manage your funds securely with ease.',
                textAlign: TextAlign.center,
                style: TextStyleHelper.instance.title16RegularPoppins
                    .copyWith(height: 1.5),
              ),
            ),
            SizedBox(height: 22.h),
            CustomButton(
              text: 'Get Started',
              buttonType: CustomButtonType.gradient,
              width: 398.h,
              height: 53.h,
              borderRadius: 26,
              onPressed: () => _handleGetStarted(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Positioned(
      bottom: 44.h,
      left: 0,
      right: 0,
      child: Center(
        child: CustomImageView(
          imagePath: ImageConstant.imgGroup1597885172,
          height: 6.h,
          width: 41.h,
        ),
      ),
    );
  }

  void _handleGetStarted(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.loginScreen);
  }
}
