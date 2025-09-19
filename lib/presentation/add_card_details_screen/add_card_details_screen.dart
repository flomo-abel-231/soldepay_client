 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';

class AddCardDetailsScreen extends StatelessWidget {
  AddCardDetailsScreen({Key? key}) : super(key: key);

  final TextEditingController cardNumberController =
      TextEditingController(text: '9273  0000  0000  0000');
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();
  bool isSaveCardChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFF1C1A,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: appTheme.colorFF1B19,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.h),
                    topRight: Radius.circular(50.h),
                  ),
                  border: Border.all(color: appTheme.whiteCustom, width: 1.h),
                ),
                child: Column(
                  children: [
                    _buildTopHandle(),
                    _buildHeader(context),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 24.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 24.h),
                            _buildCardNumberSection(),
                            SizedBox(height: 24.h),
                            _buildExpiryAndCvcSection(),
                            SizedBox(height: 24.h),
                            _buildSaveCardCheckbox(),
                            SizedBox(height: 24.h),
                            _buildAddCardButton(),
                            SizedBox(height: 24.h),
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
      ),
    );
  }

  Widget _buildTopHandle() {
    return Container(
      width: 59.h,
      height: 6.h,
      margin: EdgeInsets.only(top: 8.h),
      decoration: BoxDecoration(
        color: appTheme.colorFF4947,
        borderRadius: BorderRadius.circular(3.h),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 48.h,
      margin: EdgeInsets.only(top: 24.h),
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Row(
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
          SizedBox(width: 42.h),
          Text(
            'Add Your Card details',
            style: TextStyleHelper.instance.title18SemiBoldPoppins
                .copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildCardNumberSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Card Number',
          style: TextStyleHelper.instance.body14SemiBoldPoppins
              .copyWith(height: 1.5),
        ),
        SizedBox(height: 12.h),
        Container(
          width: 382.h,
          height: 53.h,
          decoration: BoxDecoration(
            color: appTheme.colorFF2D2B,
            border: Border.all(color: appTheme.whiteCustom, width: 1.h),
            borderRadius: BorderRadius.circular(26.h),
          ),
          child: Row(
            children: [
              SizedBox(width: 16.h),
              Container(
                width: 35.h,
                height: 35.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [Color(0xFFBE7A85), Color(0xFF3418A1)],
                  ),
                  borderRadius: BorderRadius.circular(17.h),
                ),
                child: Center(
                  child: CustomImageView(
                    imagePath: ImageConstant.imgMastercardYellow800,
                    height: 13.h,
                    width: 21.h,
                  ),
                ),
              ),
              SizedBox(width: 12.h),
              Expanded(
                child: TextFormField(
                  controller: cardNumberController,
                  style: TextStyleHelper.instance.body14MediumPoppins
                      .copyWith(height: 1.36),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Card Number',
                    hintStyle: TextStyleHelper.instance.body14MediumPoppins
                        .copyWith(color: Colors.white54),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                    CardNumberInputFormatter(),
                  ],
                ),
              ),
              SizedBox(width: 16.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpiryAndCvcSection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Expiry Date',
                style: TextStyleHelper.instance.body14SemiBoldPoppins
                    .copyWith(height: 1.5),
              ),
              SizedBox(height: 12.h),
              Container(
                height: 53.h,
                decoration: BoxDecoration(
                  color: appTheme.colorFF2D2B,
                  border: Border.all(color: appTheme.whiteCustom, width: 1.h),
                  borderRadius: BorderRadius.circular(26.h),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 16.h),
                    CustomImageView(
                      imagePath: ImageConstant.imgBoldTimeCalendar,
                      height: 18.h,
                      width: 18.h,
                    ),
                    SizedBox(width: 12.h),
                    Expanded(
                      child: TextFormField(
                        controller: expiryDateController,
                        style: TextStyleHelper.instance.body14MediumPoppins
                            .copyWith(height: 1.5),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'MM / YYYY',
                          hintStyle: TextStyleHelper
                              .instance.body14MediumPoppins
                              .copyWith(color: Colors.white54),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                          ExpiryDateInputFormatter(),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.h),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 16.h),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CVC/CVV',
                style: TextStyleHelper.instance.body14SemiBoldPoppins
                    .copyWith(height: 1.5),
              ),
              SizedBox(height: 12.h),
              Container(
                height: 53.h,
                decoration: BoxDecoration(
                  color: appTheme.colorFF2D2B,
                  border: Border.all(color: appTheme.whiteCustom, width: 1.h),
                  borderRadius: BorderRadius.circular(26.h),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: CustomImageView(
                        imagePath: ImageConstant.imgFrame2147226261,
                        height: 6.h,
                        width: 56.h,
                      ),
                    ),
                    TextFormField(
                      controller: cvcController,
                      obscureText: true,
                      style: TextStyleHelper.instance.body14MediumPoppins,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.h),
                        hintText: '•••',
                        hintStyle: TextStyleHelper.instance.body14MediumPoppins
                            .copyWith(color: Colors.white54),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSaveCardCheckbox() {
    return Row(
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgBoldEssentionalUiCheckCircle,
          height: 22.h,
          width: 22.h,
        ),
        SizedBox(width: 12.h),
        Text(
          'Save card',
          style: TextStyleHelper.instance.body14MediumPoppins
              .copyWith(height: 1.5),
        ),
      ],
    );
  }

  Widget _buildAddCardButton() {
    return CustomButton(
      text: 'Add Card',
      buttonType: CustomButtonType.gradient,
      width: 382.h,
      height: 60.h,
      borderRadius: 30,
      onPressed: () {
        // Handle add card action
      },
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    String newText = '';

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        newText += '  ';
      }
      newText += text[i];
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    String newText = '';

    if (text.length >= 2) {
      newText = text.substring(0, 2) + ' / ' + text.substring(2);
    } else {
      newText = text;
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
