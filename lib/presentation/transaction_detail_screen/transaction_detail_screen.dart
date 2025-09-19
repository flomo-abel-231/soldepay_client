import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFF0908,
      body: Column(
        children: [
          // Hero Section with Background and Success Animation
          Container(
            height: 435.h,
            width: 414.h,
            margin: EdgeInsets.only(left: 16.h),
            child: Stack(
              children: [
                // Background Image
                Positioned(
                  left: 28.h,
                  child: Container(
                    height: 435.h,
                    width: 386.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImageConstant.imgEllipse78435x386),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 115.h),
                        // Success Icon with Animated Dots
                        Container(
                          height: 200.h,
                          width: 200.h,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Animated Dots
                              _buildAnimatedDots(),
                              // Success Icon
                              CustomImageView(
                                imagePath: ImageConstant.imgGroup67,
                                height: 177.h,
                                width: 175.h,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 31.h),
                        // Amount Display
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '+\$152',
                                style: TextStyleHelper
                                    .instance.display40BoldPoppins,
                              ),
                              TextSpan(
                                text: '.00',
                                style: TextStyleHelper
                                    .instance.display40BoldPoppins,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // App Bar
                Positioned(
                  top: 27.h,
                  left: 0,
                  child: CustomAppBar(
                    title: 'Transaction Details',
                    onBackPressed: () {
                      Navigator.of(context).pop();
                    }, isAbsolutePositioned: false,
                  ),
                ),
              ],
            ),
          ),
          // Details Section
          Expanded(
            child: Container(
              width: 430.h,
              child: Stack(
                children: [
                  // Background Overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      height: 102.h,
                      width: 430.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF0A080E),
                            appTheme.colorFF0A08,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: appTheme.colorFF8888,
                            blurRadius: 54.h,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Details Content
                  Positioned(
                    top: 0,
                    left: 8.h,
                    child: Container(
                      height: 367.h,
                      width: 414.h,
                      child: Column(
                        children: [
                          // Details Card
                          Container(
                            height: 287.h,
                            width: 414.h,
                            decoration: BoxDecoration(
                              color: appTheme.whiteCustom,
                              borderRadius: BorderRadius.circular(24.h),
                              border: Border.all(color: appTheme.whiteCustom),
                              boxShadow: [
                                BoxShadow(
                                  color: appTheme.colorFF8888,
                                  blurRadius: 54.h,
                                  offset: Offset(0, 4.h),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Details',
                                    style: TextStyleHelper
                                        .instance.title18MediumPoppins,
                                  ),
                                  SizedBox(height: 16.h),
                                  Container(
                                    height: 1.h,
                                    width: 374.h,
                                    color: appTheme.whiteCustom,
                                  ),
                                  SizedBox(height: 20.h),
                                  // Transaction Details List
                                  Column(
                                    children: [
                                      _buildDetailRow(
                                          'Transaction Status', 'Successful'),
                                      SizedBox(height: 20.h),
                                      _buildDetailRow('Amount', '\$152.00'),
                                      SizedBox(height: 20.h),
                                      _buildDetailRow('Date', 'Jun 7, 2025'),
                                      SizedBox(height: 20.h),
                                      _buildDetailRow('Time', '06:14:26'),
                                      SizedBox(height: 20.h),
                                      _buildDetailRow(
                                          'Transcription ID', 'AWEfa774AA232a'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          // Done Button
                          CustomButton(
                            text: 'Done',
                            buttonType: CustomButtonType.gradient,
                            width: 414.h,
                            height: 60.h,
                            borderRadius: 30,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
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

  Widget _buildDetailRow(String label, String value) {
    return Container(
      height: 21.h,
      width: 374.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyleHelper.instance.body14RegularPoppins,
          ),
          Text(
            value,
            style: TextStyleHelper.instance.body14SemiBoldPoppins,
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedDots() {
    return Container(
      width: 200.h,
      height: 200.h,
      child: Stack(
        children: [
          _buildAnimatedDot(0.2, 0.5, 0.0),
          _buildAnimatedDot(0.3, 0.7, 0.2),
          _buildAnimatedDot(0.5, 0.8, 0.4),
          _buildAnimatedDot(0.7, 0.7, 0.6),
          _buildAnimatedDot(0.8, 0.5, 0.8),
          _buildAnimatedDot(0.7, 0.3, 1.0),
          _buildAnimatedDot(0.5, 0.2, 1.2),
          _buildAnimatedDot(0.3, 0.3, 1.4),
        ],
      ),
    );
  }

  Widget _buildAnimatedDot(double top, double left, double delay) {
    return Positioned(
      top: top * 200.h,
      left: left * 200.h,
      child: Transform.translate(
        offset: Offset(-4.h, -4.h),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.4, end: 1.0),
          duration: Duration(seconds: 2),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
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
      ),
    );
  }
}
