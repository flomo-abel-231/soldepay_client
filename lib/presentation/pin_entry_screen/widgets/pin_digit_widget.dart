import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class PinDigitWidget extends StatelessWidget {
  final String value;
  final bool isActive;
  final bool isFilled;

  PinDigitWidget({
    Key? key,
    required this.value,
    required this.isActive,
    required this.isFilled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 53.h,
      height: 53.h,
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(
          width: 1.h,
          color: appTheme.whiteCustom,
        ),
        gradient: isFilled || isActive
            ? LinearGradient(
                colors: [Color(0xFFBE7A85), Color(0xFF3418A1)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
      ),
      child: Center(
        child: isActive && !isFilled
            ? Container(
                width: 26.h,
                height: 2.h,
                color: appTheme.blackCustom,
              )
            : Text(
                value,
                style: TextStyleHelper.instance.title20Medium,
              ),
      ),
    );
  }
}
