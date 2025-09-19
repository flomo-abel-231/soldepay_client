import 'package:flutter/material.dart';
import 'package:soldepay/models/otp_request.dart';
import 'package:soldepay/services/user_service.dart';
import 'package:soldepay/widgets/custom_button.dart';
import 'package:soldepay/widgets/custom_image_view.dart';

import '../../core/app_export.dart';

class GenerateOtpScreen extends StatefulWidget {
  const GenerateOtpScreen({super.key});

  @override
  State<GenerateOtpScreen> createState() => _GenerateOtpScreenState();
}

class _GenerateOtpScreenState extends State<GenerateOtpScreen> {
  final TextEditingController _identifierController = TextEditingController();
  final UserService _userService = UserService();
  bool _isLoading = false;

  Future<void> _generateOtp() async {
    final identifier = _identifierController.text.trim();

    if (identifier.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your email.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response =
          await _userService.generateOtp(OtpRequest(identifier: identifier));
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP sent successfully")),
        );
        Navigator.of(context).pushNamed(AppRoutes.loginScreen);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: appTheme.colorFF0908,
                image: DecorationImage(
                  image: AssetImage(ImageConstant.imgEllipse78),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06, // 6% of width
                  vertical: screenHeight * 0.04, // 4% of height
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        _buildLogoSection(screenHeight),
                        SizedBox(height: screenHeight * 0.06),
                        Text(
                          'Generate OTP',
                          style: TextStyleHelper.instance.headline26BoldPoppins
                              .copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        _buildEmailInput(screenHeight),
                        SizedBox(height: screenHeight * 0.05),
                        _buildSendOtpButton(screenHeight),
                        SizedBox(height: screenHeight * 0.05),
                        CustomButton(
                          text: 'Back to Login',
                          buttonType: CustomButtonType.text,
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w600,
                          textColor: appTheme.whiteCustom,
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.loginScreen);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLogoSection(double screenHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgGroupDeepPurple90002,
          height: screenHeight * 0.05,
          width: screenHeight * 0.05,
        ),
        SizedBox(width: screenHeight * 0.02),
        CustomImageView(
          imagePath: ImageConstant.imgGroup26x110,
          height: screenHeight * 0.04,
          width: screenHeight * 0.15,
        ),
      ],
    );
  }

  Widget _buildEmailInput(double screenHeight) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
      height: screenHeight * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenHeight * 0.04),
        border: Border.all(color: appTheme.whiteCustom),
        color: Colors.white,
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgFi9581121,
            height: screenHeight * 0.035,
            width: screenHeight * 0.035,
          ),
          SizedBox(width: screenHeight * 0.02),
          Expanded(
            child: TextField(
              controller: _identifierController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyleHelper.instance.title16Poppins
                  .copyWith(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Enter your email',
                hintStyle: TextStyleHelper.instance.title16Poppins
                    .copyWith(color: Colors.grey.shade600),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSendOtpButton(double screenHeight) {
    return CustomButton(
      text: _isLoading ? 'Sending...' : 'Send OTP',
      buttonType: CustomButtonType.gradient,
      width: double.infinity,
      height: screenHeight * 0.07,
      borderRadius: screenHeight * 0.035,
      fontSize: screenHeight * 0.022,
      fontWeight: FontWeight.w600,
      onPressed: _isLoading ? null : _generateOtp,
    );
  }
}
