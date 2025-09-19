import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_image_view.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 884.h,
        width: 430.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6B46C1),
              appTheme.colorFF0908,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background Ellipse
            Positioned(
              top: 48.h,
              left: 43.h,
              child: Opacity(
                opacity: 0.2,
                child: CustomImageView(
                  imagePath: ImageConstant.imgEllipse78,
                  height: 438.h,
                  width: 386.h,
                ),
              ),
            ),

            // SoldePay Logo
            Positioned(
              top: 441.h,
              left: 133.h,
              child: Container(
                padding: EdgeInsets.all(16.h),
                decoration: BoxDecoration(
                  color: appTheme.whiteCustom,
                  borderRadius: BorderRadius.circular(8.h),
                  boxShadow: [
                    BoxShadow(
                      color: appTheme.blackCustom.withAlpha(26),
                      blurRadius: 10.h,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
                child: CustomImageView(
                  imagePath: ImageConstant.imgImage1,
                  height: 51.h,
                  width: 163.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
