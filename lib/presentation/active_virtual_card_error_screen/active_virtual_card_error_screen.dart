import 'package:flutter/material.dart';
import 'package:soldepay/core/app_export.dart';
import 'package:soldepay/widgets/custom_button.dart';

import '../../widgets/custom_image_view.dart';

class AlreadyHasCardScreen extends StatelessWidget {
  const AlreadyHasCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: appTheme.colorFF0908,
          image: DecorationImage(
            image: AssetImage(ImageConstant.imgEllipse78),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath:
                    ImageConstant.imgCardAlert, // Add a relevant icon in assets
                height: 100.h,
                width: 100.h,
              ),
              SizedBox(height: 32.h),
              Text(
                "You Already Have an Active Card",
                style: TextStyleHelper.instance.headline26BoldPoppins
                    .copyWith(color: appTheme.whiteCustom),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                "You cannot create a new virtual card until your current one is deactivated or expired.",
                style: TextStyleHelper.instance.body14Regular
                    .copyWith(color: appTheme.whiteCustom),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              CustomButton(
                text: "View My Card",
                onPressed: () {
                  Navigator.pushNamed(context,
                      AppRoutes.virtualCardScreen); // Replace with actual route
                },
                buttonType: CustomButtonType.gradient,
                height: 53.h,
                borderRadius: 26,
              ),
              SizedBox(height: 16.h),
              CustomButton(
                text: "Back to Home",
                onPressed: () {
                  Navigator.pushNamed(context,
                      AppRoutes.home_screen); // Replace with actual route
                },
                buttonType: CustomButtonType.text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
