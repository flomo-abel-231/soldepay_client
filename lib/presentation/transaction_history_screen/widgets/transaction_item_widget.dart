import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_image_view.dart';

class TransactionItemWidget extends StatelessWidget {
  final TransactionModel transaction;

  TransactionItemWidget({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.colorFF3741,
        borderRadius: BorderRadius.circular(16.h),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                height: 48.h,
                width: 48.h,
                child: CustomImageView(
                  imagePath: transaction.avatarImage ?? '',
                  height: 48.h,
                  width: 48.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CustomImageView(
                  imagePath: transaction.statusIcon ?? '',
                  height: 16.h,
                  width: 16.h,
                ),
              ),
            ],
          ),
          SizedBox(width: 12.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title ?? '',
                  style: TextStyleHelper.instance.title16Medium,
                ),
                SizedBox(height: 4.h),
                Text(
                  transaction.date ?? '',
                  style: TextStyleHelper.instance.body14Medium
                      .copyWith(color: appTheme.colorFF9CA3),
                ),
              ],
            ),
          ),
          Text(
            transaction.amount ?? '',
            style: TextStyleHelper.instance.title18Medium.copyWith(
                color: (transaction.isPositive ?? false)
                    ? Color(0xFF24F07D)
                    : appTheme.colorFFFF45),
          ),
        ],
      ),
    );
  }
}

class TransactionModel {
  String? title;
  String? date;
  String? amount;
  bool? isPositive;
  String? avatarImage;
  String? statusIcon;

  TransactionModel({
    this.title,
    this.date,
    this.amount,
    this.isPositive,
    this.avatarImage,
    this.statusIcon,
  });

  get name => null;
}
