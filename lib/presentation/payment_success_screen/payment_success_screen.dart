import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_image_view_copy.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String recipientName;
  final double amount;
  final String transactionId;
  final String date;

  PaymentSuccessScreen({
    Key? key,
    this.recipientName = "",
    this.amount = 430.00,
    this.transactionId = "erfa774AA232a",
    this.date = "Feb 14, 2025",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFF0908,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeaderSection(context),
              _buildTransactionDetailsCard(context),
              SizedBox(height: 24.h),
              _buildDoneButton(context),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      height: 435.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageConstant.imgEllipse78),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          CustomAppBar(
            onBackPressed: () => Navigator.of(context).pop(),
            isAbsolutePositioned: false,
          ),
          Positioned(
            top: 41.h,
            left: 32.h,
            right: 32.h,
            child: Column(
              children: [
                Text(
                  'Payment Successful',
                  style: TextStyleHelper.instance.title18SemiBold.copyWith(
                    color: appTheme.whiteCustom,
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\$',
                      style: TextStyleHelper.instance.display40Bold.copyWith(
                        color: appTheme.whiteCustom,
                      ),
                    ),
                    Text(
                      amount.toStringAsFixed(2),
                      style: TextStyleHelper.instance.display40Bold.copyWith(
                        color: appTheme.whiteCustom,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessAnimationContainer() {
    return SizedBox(
      width: 175.h,
      height: 177.h,
      child: Stack(
        children: [
          ..._buildFloatingDots(),
          Center(
            child: CustomImageView(
              imagePath: ImageConstant.imgGroup67,
              height: 177.h,
              width: 175.h,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFloatingDots() {
    List<Map<String, double>> dotPositions = [
      {'top': 20.h, 'left': 40.h},
      {'top': 10.h, 'left': 80.h},
      {'top': 30.h, 'left': 120.h},
      {'top': 60.h, 'left': 150.h},
      {'top': 100.h, 'left': 160.h},
      {'top': 140.h, 'left': 140.h},
      {'top': 160.h, 'left': 100.h},
      {'top': 150.h, 'left': 60.h},
      {'top': 120.h, 'left': 20.h},
      {'top': 80.h, 'left': 10.h},
    ];

    return dotPositions.asMap().entries.map((entry) {
      final position = entry.value;

      return Positioned(
        top: position['top'],
        left: position['left'],
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: -10.0),
          duration: const Duration(seconds: 2),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, value),
              child: Container(
                width: 8.h,
                height: 8.h,
                decoration: BoxDecoration(
                  color: appTheme.whiteCustom,
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        ),
      );
    }).toList();
  }

  Widget _buildTransactionDetailsCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        borderRadius: BorderRadius.circular(24.h),
        boxShadow: [
          BoxShadow(
            color: appTheme.colorFF8888.withOpacity(0.25),
            blurRadius: 54.h,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgEllipse78,
                height: 49.h,
                width: 49.h,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10.h),
              Text(
                recipientName,
                style: TextStyleHelper.instance.title18Medium,
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 8.h),
                decoration: BoxDecoration(
                  color: appTheme.colorFFF5F5,
                  borderRadius: BorderRadius.circular(17.h),
                ),
                child: Text(
                  '-\$${amount.toStringAsFixed(2)}',
                  style: TextStyleHelper.instance.body12Medium,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Divider(color: appTheme.colorFFE5E7, thickness: 1.h),
          SizedBox(height: 16.h),
          _buildInfoRow('Transaction ID', transactionId),
          SizedBox(height: 12.h),
          _buildInfoRow('Date', date),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyleHelper.instance.body14Regular),
        Text(value, style: TextStyleHelper.instance.body14SemiBold),
      ],
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      height: 60.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFbe7a85), Color(0xFF3418a1)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30.h),
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.h),
          ),
        ),
        child: Text(
          'Done',
          style: TextStyleHelper.instance.title16Medium.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
