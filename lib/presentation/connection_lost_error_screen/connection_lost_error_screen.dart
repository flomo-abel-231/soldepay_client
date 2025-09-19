import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';

class ConnectionLostErrorScreen extends StatelessWidget {
  const ConnectionLostErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.blackCustom,
      body: Container(
        height: 884.h,
        width: 430.h,
        padding: EdgeInsets.all(16.h),
        child: Center(
          child: _buildErrorDialog(context),
        ),
      ),
    );
  }

  Widget _buildErrorDialog(BuildContext context) {
    return Container(
      height: 328.h,
      width: 414.h,
      padding: EdgeInsets.all(32.h),
      decoration: BoxDecoration(
        color: appTheme.colorFF1B19,
        border: Border.all(color: appTheme.whiteCustom, width: 1.h),
        borderRadius: BorderRadius.circular(24.h),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildErrorIcon(),
          SizedBox(height: 24.h),
          _buildErrorTitle(),
          SizedBox(height: 16.h),
          _buildErrorDescription(),
          SizedBox(height: 32.h),
          _buildTryAgainButton(context),
        ],
      ),
    );
  }

  Widget _buildErrorIcon() {
    return Container(
      height: 84.h,
      width: 84.h,
      decoration: BoxDecoration(
        color: appTheme.color19ED3E,
        border: Border.all(color: appTheme.whiteCustom, width: 1.h),
        borderRadius: BorderRadius.circular(42.h),
      ),
      child: Center(
        child: CustomImageView(
          imagePath: ImageConstant.imgExclamation11,
          height: 40.h,
          width: 40.h,
        ),
      ),
    );
  }

  Widget _buildErrorTitle() {
    return Text(
      'Connection lost',
      style: TextStyleHelper.instance.headline24SemiBoldPoppins
          .copyWith(height: 1.54),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildErrorDescription() {
    return Container(
      width: 318.h,
      child: Text(
        'Check your internet connection and try again',
        style:
            TextStyleHelper.instance.body14RegularPoppins.copyWith(height: 1.5),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTryAgainButton(BuildContext context) {
    return CustomButton(
      text: 'Try Again',
      width: 350.h,
      height: 60.h,
      backgroundColor: appTheme.whiteCustom,
      textColor: appTheme.blackCustom,
      borderRadius: 30,
      fontSize: 16.fSize,
      fontWeight: FontWeight.w500,
      onPressed: () {
        _handleRetryConnection(context);
      },
    );
  }

  void _handleRetryConnection(BuildContext context) {
    // Simulate retry connection logic
    // In a real app, this would check network connectivity
    // For now, we'll just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Checking connection...'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
