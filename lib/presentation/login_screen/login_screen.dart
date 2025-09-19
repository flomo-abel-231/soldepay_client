import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soldepay/models/login_request.dart';
import 'package:soldepay/services/user_service.dart';
import 'package:soldepay/widgets/custom_button.dart';
import 'package:soldepay/widgets/custom_image_view.dart';

import '../../core/app_export.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final UserService _userService = UserService();

  bool isPasswordVisible = false;
  bool rememberPassword = false;
  bool isLoading = false;

  Future<void> _login() async {
    final identifier = _identifierController.text.trim();
    final password = _passwordController.text;
    final otp = _otpController.text;

    if (identifier.isEmpty || password.isEmpty || otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required.")),
      );
      return;
    }

    setState(() => isLoading = true);

    final loginRequest = LoginRequest(
      identifier: identifier,
      password: password,
      otp: otp,
    );

    try {
      final response = await _userService.loginWithOtp(loginRequest);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('firstName', jsonData['firstName'] ?? '');
        await prefs.setString('lastName', jsonData['lastName'] ?? '');
        await prefs.setString('dateOfBirth', jsonData['dateOfBirth'] ?? '');
        await prefs.setString('email', jsonData['email'] ?? '');
        await prefs.setString('address', jsonData['address'] ?? '');
        await prefs.setString('phoneNumber', jsonData['phoneNumber'] ?? '');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful")),
        );
        Navigator.of(context).pushNamed(AppRoutes.home_screen);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login Failed: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget _buildLogoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgGroupDeepPurple90002,
          height: 32.h,
          width: 29.h,
        ),
        SizedBox(width: 8.h),
        CustomImageView(
          imagePath: ImageConstant.imgGroup26x110,
          height: 26.h,
          width: 110.h,
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required String iconPath,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      height: 64.h,
      decoration: BoxDecoration(
        border: Border.all(color: appTheme.whiteCustom),
        borderRadius: BorderRadius.circular(32.h),
      ),
      child: Row(
        children: [
          SizedBox(width: 20.h),
          CustomImageView(imagePath: iconPath, height: 20.h, width: 20.h),
          SizedBox(width: 12.h),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              style: TextStyleHelper.instance.title16Poppins,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyleHelper.instance.title16Poppins,
                border: InputBorder.none,
              ),
            ),
          ),
          if (suffixIcon != null) suffixIcon,
          SizedBox(width: 20.h),
        ],
      ),
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => setState(() => rememberPassword = !rememberPassword),
              child: Container(
                width: 16.h,
                height: 16.h,
                decoration: BoxDecoration(
                  border: Border.all(color: appTheme.whiteCustom),
                  borderRadius: BorderRadius.circular(2.h),
                ),
                child: rememberPassword
                    ? CustomImageView(
                        imagePath: ImageConstant.imgFi25235,
                        height: 16.h,
                        width: 16.h,
                      )
                    : null,
              ),
            ),
            SizedBox(width: 8.h),
            Text('Remember Password',
                style: TextStyleHelper.instance.body14MediumPoppins),
          ],
        ),
        CustomButton(
          text: 'Forgot Password',
          buttonType: CustomButtonType.text,
          fontSize: 14.fSize,
          fontWeight: FontWeight.w600,
          textColor: appTheme.whiteCustom,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return CustomButton(
      text: isLoading ? 'Logging in...' : 'Login',
      buttonType: CustomButtonType.gradient,
      width: double.infinity,
      height: 53.h,
      borderRadius: 26,
      fontSize: 16.fSize,
      fontWeight: FontWeight.w500,
      onPressed: isLoading ? null : _login,
    );
  }

  Widget _buildRegisterLink() {
    return RichText(
      text: TextSpan(
        text: "Don't Have an Account? ",
        style: TextStyleHelper.instance.title16MediumPoppins,
        children: [
          WidgetSpan(
            child: GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRoutes.registerScreen),
              child: Text(
                'Register now',
                style: TextStyleHelper.instance.title16BoldPoppins.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: appTheme.colorFF0908,
        image: DecorationImage(
          image: AssetImage(ImageConstant.imgEllipse78),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              _buildLogoSection(),
              SizedBox(height: 32.h),
              Text(
                'Welcome To SoldePay',
                style: TextStyleHelper.instance.headline26BoldPoppins
                    .copyWith(height: 1.5),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              _buildInputField(
                controller: _identifierController,
                hintText: 'Enter your email',
                iconPath: ImageConstant.imgFi9581121,
              ),
              SizedBox(height: 24.h),
              _buildInputField(
                controller: _passwordController,
                hintText: 'Password',
                iconPath: ImageConstant.imgFi9581121,
                obscureText: !isPasswordVisible,
                suffixIcon: GestureDetector(
                  onTap: () =>
                      setState(() => isPasswordVisible = !isPasswordVisible),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgFrameWhiteA700,
                      height: 20.h,
                      width: 20.h,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              _buildInputField(
                controller: _otpController,
                hintText: 'Enter OTP sent to your email',
                iconPath: ImageConstant.imgFrame,
              ),
              SizedBox(height: 8.h),
              CustomButton(
                text: 'Resend OTP',
                buttonType: CustomButtonType.text,
                fontSize: 14.fSize,
                fontWeight: FontWeight.w600,
                textColor: appTheme.whiteCustom,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.generate_otp_screen);
                },
              ),
              SizedBox(height: 8.h),
              _buildRememberForgot(),
              SizedBox(height: 24.h),
              _buildLoginButton(),
              SizedBox(height: 48.h),
              _buildRegisterLink(),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildMainContent(context),
    );
  }
}
