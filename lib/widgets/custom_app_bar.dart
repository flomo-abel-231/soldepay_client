import 'package:flutter/material.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

/**
 * CustomAppBar - A reusable app bar component with back navigation
 * 
 * Features:
 * - Circular back button with white background and shadow
 * - Optional title display with white text
 * - Consistent styling across all variants
 * - Responsive design using SizeUtils
 * 
 * @param title - Optional title text to display
 * @param onBackPressed - Callback function when back button is pressed
 * @param showTitle - Whether to show the title (defaults to true if title is provided)
 */
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.onBackPressed,
    this.showTitle, required bool isAbsolutePositioned,
  }) : super(key: key);

  /// Optional title text to display in the app bar
  final String? title;

  /// Callback function triggered when back button is pressed
  final VoidCallback? onBackPressed;

  /// Whether to show the title (defaults to true if title is provided)
  final bool? showTitle;

  @override
  Widget build(BuildContext context) {
    final shouldShowTitle = showTitle ?? (title != null);

    return AppBar(
      backgroundColor: appTheme.transparentCustom,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: Container(
        margin: EdgeInsets.all(4.h),
        child: Material(
          color: appTheme.whiteCustom,
          shape: CircleBorder(),
          elevation: 4.h,
          child: InkWell(
            borderRadius: BorderRadius.circular(28.h),
            onTap: onBackPressed ?? () => Navigator.of(context).pop(),
            child: Container(
              width: 56.h,
              height: 56.h,
              decoration: BoxDecoration(
                color: appTheme.whiteCustom,
                shape: BoxShape.circle,
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
        ),
      ),
      title: shouldShowTitle && title != null
          ? Text(
              title!,
              style: TextStyleHelper.instance.title18SemiBoldPoppins,
            )
          : null,
      centerTitle: true,
      actions: shouldShowTitle && title != null
          ? [
              SizedBox(width: 56.h), // Spacer for centering
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
