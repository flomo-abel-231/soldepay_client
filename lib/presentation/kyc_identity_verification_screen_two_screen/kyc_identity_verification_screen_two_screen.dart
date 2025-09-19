import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_image_view_copy.dart';

class KycIdentityVerificationScreenTwo extends StatelessWidget {
  KycIdentityVerificationScreenTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFF0908,
      body: _buildMainContent(context),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          _buildBackgroundDecoration(),
          _buildContentColumn(context),
        ],
      ),
    );
  }

  Widget _buildBackgroundDecoration() {
    return Positioned(
      top: 48.h,
      left: 43.h,
      child: Opacity(
        opacity: 0.2,
        child: CustomImageView(
          imagePath: ImageConstant.imgEllipse78435x386,
          height: 438.h,
          width: 386.h,
        ),
      ),
    );
  }

  Widget _buildContentColumn(BuildContext context) {
    return Positioned(
      top: 75.h,
      left: 8.h,
      child: Container(
        width: 414.h,
        height: 418.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            SizedBox(height: 24.h),
            Expanded(
              child: _buildVerificationCard(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      width: 218.h,
      height: 56.h,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: 56.h,
              width: 56.h,
              decoration: BoxDecoration(
                color: appTheme.whiteCustom,
                borderRadius: BorderRadius.circular(28.h),
              ),
              child: Center(
                child: CustomImageView(
                  imagePath: ImageConstant.imgArrowleft,
                  height: 24.h,
                  width: 24.h,
                ),
              ),
            ),
          ),
          SizedBox(width: 68.h),
          Text(
            'KYC',
            style: TextStyleHelper.instance.title18SemiBoldPoppins
                .copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationCard(BuildContext context) {
    return Container(
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
      padding: EdgeInsets.all(24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(),
          SizedBox(height: 32.h),
          _buildUploadSection(context),
          SizedBox(height: 32.h),
          _buildNextButton(context),
        ],
      ),
    );
  }

  Widget _buildCardHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify Your Identity',
          style: TextStyleHelper.instance.headline24SemiBoldPoppins
              .copyWith(color: appTheme.blackCustom, height: 1.5),
        ),
        SizedBox(height: 15.h),
        Text(
          'Please upload a valid government-issued\nID to complete your verification-',
          style: TextStyleHelper.instance.body14RegularPoppins
              .copyWith(color: appTheme.colorFF6B72, height: 1.57),
        ),
      ],
    );
  }

  Widget _buildUploadSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Government ID:',
          style: TextStyleHelper.instance.body12MediumPoppins
              .copyWith(height: 1.5),
        ),
        SizedBox(height: 10.h),
        _buildFileUploadContainer(context),
      ],
    );
  }

  Widget _buildFileUploadContainer(BuildContext context) {
    return Container(
      height: 54.h,
      width: double.maxFinite,
      child: Stack(
        children: [
          Container(
            height: 54.h,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: appTheme.colorFFF9FA,
              border: Border.all(color: appTheme.colorFFD1D5),
              borderRadius: BorderRadius.circular(16.h),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF888888).withAlpha(26),
                  blurRadius: 54.h,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 12.h),
                child: Text(
                  'No file chosen',
                  style: TextStyleHelper.instance.body12MediumPoppins
                      .copyWith(color: appTheme.colorFF6B72, height: 1.5),
                ),
              ),
            ),
          ),
          Positioned(
            top: 12.h,
            left: 12.h,
            child: GestureDetector(
              onTap: () {
                // Handle file selection
              },
              child: Container(
                height: 29.h,
                width: 97.h,
                decoration: BoxDecoration(
                  color: appTheme.colorFFF3F4,
                  border: Border.all(color: appTheme.colorFFD1D5),
                  borderRadius: BorderRadius.circular(8.h),
                ),
                child: Center(
                  child: Text(
                    'Choose File',
                    style: TextStyleHelper.instance.body12MediumPoppins
                        .copyWith(height: 1.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle next step
      },
      child: Container(
        width: double.maxFinite,
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
            style: TextStyleHelper.instance.title16MediumPoppins
                .copyWith(height: 1.5),
          ),
        ),
      ),
    );
  }
}
