import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_image_view.dart';
import './widgets/transaction_item_widget.dart';

class TransactionHistoryScreen extends StatelessWidget {
  TransactionHistoryScreen({Key? key}) : super(key: key);

  List<TransactionModel> transactionsList = [
    TransactionModel(
      title: 'Added via Credit Card',
      date: 'Dec 28, 2024',
      amount: '+\$120.52',
      isPositive: true,
      avatarImage: ImageConstant.imgGroup238129,
      statusIcon: ImageConstant.imgGroup238136,
    ),
    TransactionModel(
      title: 'Sent to John Smith',
      date: 'Jan 24, 2024',
      amount: '-\$120.52',
      isPositive: false,
      avatarImage: ImageConstant.imgEllipse7848x48,
      statusIcon: ImageConstant.imgGroup238136WhiteA700,
    ),
    TransactionModel(
      title: 'Received from Emily',
      date: 'Feb 15, 2024',
      amount: '+\$80.25',
      isPositive: true,
      avatarImage: ImageConstant.imgEllipse781,
      statusIcon: ImageConstant.imgGroup238136WhiteA70018x18,
    ),
    TransactionModel(
      title: 'Received from Ralph',
      date: 'Feb 15, 2024',
      amount: '+\$80.25',
      isPositive: true,
      avatarImage: ImageConstant.imgEllipse782,
      statusIcon: ImageConstant.imgGroup238136WhiteA70018x18,
    ),
    TransactionModel(
      title: 'Sent to Bessie Cooper',
      date: 'Feb 15, 2024',
      amount: '-\$410.65',
      isPositive: false,
      avatarImage: ImageConstant.imgEllipse783,
      statusIcon: ImageConstant.imgGroup238136WhiteA700,
    ),
    TransactionModel(
      title: 'Received from Floyd',
      date: 'Feb 15, 2024',
      amount: '+\$80.25',
      isPositive: true,
      avatarImage: ImageConstant.imgEllipse784,
      statusIcon: ImageConstant.imgGroup238136WhiteA70018x18,
    ),
    TransactionModel(
      title: 'Sent to Theresa Webb',
      date: 'Feb 15, 2024',
      amount: '-\$180.87',
      isPositive: false,
      avatarImage: ImageConstant.imgEllipse785,
      statusIcon: ImageConstant.imgGroup238136WhiteA700,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: SizeUtils.height,
        width: SizeUtils.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF09080D),
              appTheme.colorFF2D1B,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 44.h,
              child: CustomImageView(
                imagePath: ImageConstant.imgEllipse78435x386,
                height: 435.h,
                width: 386.h,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                CustomAppBar(
                  title: 'Transaction History',
                  onBackPressed: () => Navigator.of(context).pop(), isAbsolutePositioned: false,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 8.h,
                        right: 8.h,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF1A1A1A),
                                appTheme.colorFF2D2D,
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.h),
                              topRight: Radius.circular(24.h),
                            ),
                          ),
                          child: Column(
                            children: [
                              _buildHistoryHeader(),
                              Expanded(
                                child: _buildTransactionsList(
                                    context), // Modified: Added context parameter
                              ),
                            ],
                          ),
                        ),
                      ),
                      _buildBottomNavigation(
                          context), // Modified: Added context parameter
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'History',
            style: TextStyleHelper.instance.title18SemiBold,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border.all(color: appTheme.colorFF6666),
              borderRadius: BorderRadius.circular(16.h),
            ),
            child: Row(
              children: [
                Text(
                  'Last 7 Days',
                  style: TextStyleHelper.instance.title16Medium,
                ),
                SizedBox(width: 8.h),
                CustomImageView(
                  imagePath: ImageConstant.imgArrowdown,
                  height: 20.h,
                  width: 20.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList(BuildContext context) {
    // Modified: Added context parameter
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: ListView.builder(
        itemCount: transactionsList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: TransactionItemWidget(
              transaction: transactionsList[index],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    // Modified: Added context parameter
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
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
        child: Padding(
          padding: EdgeInsets.fromLTRB(48.h, 24.h, 48.h, 24.h),
          child: Container(
            padding: EdgeInsets.all(4.h),
            decoration: BoxDecoration(
              color: appTheme.colorFF2523,
              borderRadius: BorderRadius.circular(34.h),
              boxShadow: [
                BoxShadow(
                  color: appTheme.colorFF8888,
                  blurRadius: 44.h,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(AppRoutes.walletOnboardingScreen),
                  child: Container(
                    height: 60.h,
                    width: 60.h,
                    decoration: BoxDecoration(
                      color: appTheme.whiteCustom,
                      borderRadius: BorderRadius.circular(30.h),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8.h,
                          offset: Offset(0, 2.h),
                        ),
                      ],
                    ),
                    child: Center(
                      child: CustomImageView(
                        imagePath: ImageConstant.imgBoldEssentionalUiHomeAngle,
                        height: 24.h,
                        width: 24.h,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 60.h,
                    width: 60.h,
                    decoration: BoxDecoration(
                      color: appTheme.whiteCustom,
                      borderRadius: BorderRadius.circular(30.h),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8.h,
                          offset: Offset(0, 2.h),
                        ),
                      ],
                    ),
                    child: Center(
                      child: CustomImageView(
                        imagePath: ImageConstant.imgFrameWhiteA70060x60,
                        height: 24.h,
                        width: 24.h,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.h, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: appTheme.whiteCustom,
                    borderRadius: BorderRadius.circular(30.h),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.h,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                  child: Text(
                    'History',
                    style: TextStyleHelper.instance.title16Bold,
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.loginScreen),
                  child: Container(
                    height: 60.h,
                    width: 60.h,
                    decoration: BoxDecoration(
                      color: appTheme.whiteCustom,
                      borderRadius: BorderRadius.circular(30.h),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8.h,
                          offset: Offset(0, 2.h),
                        ),
                      ],
                    ),
                    child: Center(
                      child: CustomImageView(
                        imagePath: ImageConstant.imgBoldUsersUserRounded,
                        height: 24.h,
                        width: 24.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Modified: Removed duplicate TransactionModel class to avoid conflict
