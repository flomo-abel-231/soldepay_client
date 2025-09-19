import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_image_view_copy.dart';

class InsufficientFundsScreen extends StatelessWidget {
  InsufficientFundsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.blackCustom,
      body: Container(
        height: 884.h,
        width: 430.h,
        padding: EdgeInsets.all(16.h),
        child: Center(
          child: _buildInsufficientFundsDialog(context),
        ),
      ),
    );
  }

  Widget _buildInsufficientFundsDialog(BuildContext context) {
    return Container(
      width: 414.h,
      height: 328.h,
      padding: EdgeInsets.all(32.h),
      decoration: BoxDecoration(
        color: appTheme.colorFF1B19,
        border: Border.all(color: appTheme.whiteCustom),
        borderRadius: BorderRadius.circular(24.h),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildWarningIconContainer(),
          SizedBox(height: 24.h),
          _buildTitle(),
          SizedBox(height: 16.h),
          _buildDescription(),
          SizedBox(height: 32.h),
          _buildTryAgainButton(context),
        ],
      ),
    );
  }

  Widget _buildWarningIconContainer() {
    return Container(
      height: 84.h,
      width: 84.h,
      decoration: BoxDecoration(
        color: appTheme.color19ED3E,
        border: Border.all(color: appTheme.whiteCustom),
        borderRadius: BorderRadius.circular(42.h),
      ),
      child: Center(
        child: CustomImageView(
          imagePath: ImageConstant.imgNomoney2,
          height: 32.h,
          width: 39.h,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Insufficient Funds',
      style: TextStyleHelper.instance.headline24SemiBoldPoppins
          .copyWith(height: 1.54),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription() {
    return Container(
      width: 337.h,
      child: Text(
        'Insufficient funds. Please add money to proceed',
        style:
            TextStyleHelper.instance.body14RegularPoppins.copyWith(height: 1.5),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTryAgainButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        height: 60.h,
        width: 350.h,
        decoration: BoxDecoration(
          color: appTheme.whiteCustom,
          borderRadius: BorderRadius.circular(30.h),
        ),
        child: Center(
          child: Text(
            'Try Again',
            style: TextStyleHelper.instance.title16MediumPoppins
                .copyWith(color: appTheme.blackCustom, height: 1.5),
          ),
        ),
      ),
    );
  }
}
