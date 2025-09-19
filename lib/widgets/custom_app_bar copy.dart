import 'package:flutter/material.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

/**
 * CustomAppBar - A flexible app bar component that supports various layouts
 * 
 * Features:
 * - Optional title display
 * - Circular back button with custom callback
 * - Support for both normal and absolute positioning
 * - Responsive design with SizeUtils
 * - Consistent styling across all variants
 * 
 * @param title - Optional title text to display
 * @param onBackPressed - Required callback function for back button tap
 * @param isAbsolutePositioned - Whether to use absolute positioning for overlay mode
 * @param backgroundColor - Optional background color for the app bar
 */
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    required this.onBackPressed,
    this.isAbsolutePositioned = false,
    this.backgroundColor,
  }) : super(key: key);

  /// Optional title text to display in the app bar
  final String? title;

  /// Callback function triggered when back button is pressed
  final VoidCallback onBackPressed;

  /// Whether to use absolute positioning for overlay mode
  final bool isAbsolutePositioned;

  /// Optional background color for the app bar
  final Color? backgroundColor;

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    if (isAbsolutePositioned) {
      return _buildAbsolutePositionedAppBar();
    }

    return AppBar(
      backgroundColor: backgroundColor ?? appTheme.transparentCustom,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 56.h,
      flexibleSpace: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Row(
          children: [
            _buildBackButton(),
            if (title != null) ...[
              SizedBox(width: 16.h),
              Expanded(
                child: Text(
                  title!,
                  style: TextStyleHelper.instance.title18SemiBold
                      .copyWith(height: 1.5),
                ),
              ),
              SizedBox(width: 56.h), // Spacer for centering
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAbsolutePositionedAppBar() {
    return Positioned(
      top: 27.h,
      left: 16.h,
      child: _buildBackButton(),
    );
  }

  Widget _buildBackButton() {
    return SizedBox(
      height: 56.h,
      width: 56.h,
      child: ElevatedButton(
        onPressed: onBackPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.whiteCustom,
          shape: CircleBorder(),
          padding: EdgeInsets.zero,
          elevation: 0,
        ),
        child: CustomImageView(
          imagePath: ImageConstant.imgArrowleft,
          height: 24.h,
          width: 24.h,
        ),
      ),
    );
  }
}
