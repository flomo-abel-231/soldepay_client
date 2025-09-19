import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';

class LoginSuccessScreen extends StatelessWidget {
  LoginSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.blackCustom,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.h),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(maxWidth: 400.h),
              decoration: BoxDecoration(
                color: appTheme.colorFF1B19,
                border: Border.all(color: appTheme.whiteCustom),
                borderRadius: BorderRadius.circular(24.h),
              ),
              padding: EdgeInsets.all(32.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSuccessIcon(),
                  SizedBox(height: 32.h),
                  _buildSuccessTitle(),
                  SizedBox(height: 16.h),
                  _buildSuccessDescription(),
                  SizedBox(height: 32.h),
                  _buildGoToHomeButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 84.h,
      height: 84.h,
      decoration: BoxDecoration(
        color: appTheme.colorFF00B8,
        border: Border.all(color: appTheme.whiteCustom),
        borderRadius: BorderRadius.circular(42.h),
      ),
      child: Center(
        child: CustomImageView(
          imagePath: ImageConstant.imgVector,
          height: 40.h,
          width: 40.h,
        ),
      ),
    );
  }

  Widget _buildSuccessTitle() {
    return Text(
      'Login Successful',
      style: TextStyleHelper.instance.headline24SemiBold.copyWith(height: 1.54),
    );
  }

  Widget _buildSuccessDescription() {
    return Container(
      constraints: BoxConstraints(maxWidth: 309.h),
      child: Text(
        'Login successful! Redirecting you to your dashboard for quick access to your balance and transactions.',
        textAlign: TextAlign.center,
        style: TextStyleHelper.instance.body14Regular.copyWith(height: 1.57),
      ),
    );
  }

  Widget _buildGoToHomeButton(BuildContext context) {
    return CustomButton(
      text: 'Go To Home',
      buttonType: CustomButtonType.gradient,
      width: double.infinity,
      height: 60.h,
      borderRadius: 30,
      onPressed: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.walletOnboardingScreen,
          (route) => false,
        );
      },
    );
  }
}
