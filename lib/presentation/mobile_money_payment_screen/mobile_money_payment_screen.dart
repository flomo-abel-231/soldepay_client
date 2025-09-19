import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';

class MobileMoneyPaymentScreen extends StatelessWidget {
  MobileMoneyPaymentScreen({Key? key}) : super(key: key);

  TextEditingController mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFF1118,
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          _buildBottomSheet(context),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.colorFF1B19,
        border: Border.all(color: appTheme.whiteCustom),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.h),
          topRight: Radius.circular(50.h),
        ),
      ),
      padding: EdgeInsets.all(24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandleBar(),
          SizedBox(height: 16.h),
          _buildHeaderRow(context),
          SizedBox(height: 24.h),
          _buildMobileNumberLabel(),
          SizedBox(height: 12.h),
          _buildMobileNumberInput(),
          SizedBox(height: 24.h),
          _buildConfirmButton(context), // Modified: Added context parameter
        ],
      ),
    );
  }

  Widget _buildHandleBar() {
    return Container(
      width: 59.h,
      height: 6.h,
      decoration: BoxDecoration(
        color: appTheme.colorFF4947,
        borderRadius: BorderRadius.circular(3.h),
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: 48.h,
            height: 48.h,
            child: CustomImageView(
              imagePath: ImageConstant.imgGroup27,
              height: 48.h,
              width: 48.h,
            ),
          ),
        ),
        SizedBox(width: 80.h),
        Text(
          'Mobile Money',
          style: TextStyleHelper.instance.title18SemiBold.copyWith(height: 1.5),
        ),
      ],
    );
  }

  Widget _buildMobileNumberLabel() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Mobile Number',
        style: TextStyleHelper.instance.body14SemiBold.copyWith(height: 1.5),
      ),
    );
  }

  Widget _buildMobileNumberInput() {
    return Container(
      height: 53.h,
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        border: Border.all(color: appTheme.whiteCustom),
        borderRadius: BorderRadius.circular(26.h),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgOutlineCallPhoneRounded,
            height: 24.h,
            width: 24.h,
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: TextFormField(
              controller: mobileNumberController,
              keyboardType: TextInputType.phone,
              style:
                  TextStyleHelper.instance.title16Regular.copyWith(height: 1.5),
              decoration: InputDecoration(
                hintText: 'Enter Mobile Number',
                hintStyle: TextStyleHelper.instance.title16Regular
                    .copyWith(color: appTheme.colorFF9CA3, height: 1.5),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    // Modified: Added context parameter to method signature
    return CustomButton(
      text: 'Confirms',
      buttonType: CustomButtonType.gradient,
      width: double.infinity,
      height: 60.h,
      borderRadius: 30,
      onPressed: () {
        if (mobileNumberController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a mobile number')),
          );
          return;
        }
        // Handle payment confirmation
      },
    );
  }
}
