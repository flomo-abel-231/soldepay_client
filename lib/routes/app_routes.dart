import 'package:flutter/material.dart';
import 'package:soldepay/presentation/active_virtual_card_error_screen/active_virtual_card_error_screen.dart';
import 'package:soldepay/presentation/addMoneyScreen/mtnMomoAddMoneyScreen.dart';
import 'package:soldepay/presentation/create_virtual_card_screen/create_virtual_card_screen.dart';
import 'package:soldepay/presentation/generate_otp_screen/generate_otp_screen.dart';
import 'package:soldepay/presentation/home_screen/home_screen.dart';
import 'package:soldepay/presentation/payment_confirmation_screen%20copy/payment_confirmation_screen.dart';
import 'package:soldepay/presentation/transactionsScreen/transactionsScreen.dart';
import 'package:soldepay/presentation/upload_document_screen/upload_document_screen.dart';
import 'package:soldepay/presentation/virtual_card_secureWeb/virtual_card_secureWebView.dart';

import '../presentation/add_card_details_screen/add_card_details_screen.dart';
import '../presentation/connection_lost_error_screen/connection_lost_error_screen.dart';
import '../presentation/insufficient_funds_screen/insufficient_funds_screen.dart';
// app 2

import '../presentation/invalid_recipient_error_screen/invalid_recipient_error_screen.dart';
import '../presentation/kyc_identity_verification_screen/kyc_identity_verification_screen.dart';
import '../presentation/kyc_identity_verification_screen_two_screen/kyc_identity_verification_screen_two_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/login_success_screen/login_success_screen.dart';
import '../presentation/mobile_money_payment_screen/mobile_money_payment_screen.dart';
import '../presentation/otp_verification_screen/otp_verification_screen.dart';
import '../presentation/payment_success_screen/payment_success_screen.dart';
import '../presentation/payments_onboarding_screen/payments_onboarding_screen.dart';
import '../presentation/pin_entry_screen/pin_entry_screen.dart';
import '../presentation/register_screen/register_screen.dart';
import '../presentation/send_money_screen/send_money_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/transaction_detail_screen/transaction_detail_screen.dart';
import '../presentation/transaction_failed_screen/transaction_failed_screen.dart';
import '../presentation/transaction_history_screen/transaction_history_screen.dart';
import '../presentation/transaction_pin_confirmation_screen/transaction_pin_confirmation_screen.dart';
import '../presentation/transaction_pin_confirmation_screen_two_screen/transaction_pin_confirmation_screen_two_screen.dart';
import '../presentation/wallet_onboarding_screen/wallet_onboarding_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String walletOnboardingScreen = '/wallet_onboarding_screen';
  static const String transactionHistoryScreen = '/transaction_history_screen';
  static const String connectionLostErrorScreen =
      '/connection_lost_error_screen';
  static const String loginScreen = '/login_screen';
  static const String paymentsOnboardingScreen = '/payments_onboarding_screen';
  static const String paymentConfirmationScreen =
      '/payment_confirmation_screen';
  static const String mobileMoneyPaymentScreen = '/mobile_money_payment_screen';
  static const String pinEntryScreen = '/pin_entry_screen';
  static const String addCardDetailsScreen = '/add_card_details_screen';
  static const String loginSuccessScreen = '/login_success_screen';
  static const String otpVerificationScreen = '/otp_verification_screen';
  static const String transactionDetailScreen = '/transaction_detail_screen';

  static const String appNavigationScreen = '/app_navigation_screen';
  static const String initialRoute = '/initialRoute';

  static const String invalidRecipientErrorScreen =
      '/invalid_recipient_error_screen';
  static const String sendMoneyScreen = '/send_money_screen';
  static const String kycIdentityVerificationScreen =
      '/kyc_identity_verification_screen';
  static const String transactionPinConfirmationScreen =
      '/transaction_pin_confirmation_screen';
  static const String transactionFailedScreen = '/transaction_failed_screen';
  static const String insufficientFundsScreen = '/insufficient_funds_screen';
  static const String kycIdentityVerificationScreenTwo =
      '/kyc_identity_verification_screen_two';
  static const String transactionPinConfirmationScreenTwo =
      '/transaction_pin_confirmation_screen_two';
  static const String paymentSuccessScreen = '/payment_success_screen';
  static const String createAccountScreen = '/create_account_screen';
  static const String registerScreen = '/register_screen';
  static const String home_screen = '/home_screen';
  static const String generate_otp_screen = '/generate_otp_screen';
  static const String documentUploadScreen = '/document_upload_screen';
  static const String virtualCardPaymentScreen = '/virtual_card_payment_screen';
  static const String virtualCardScreen = "/virtual_card_screen";
  static const String alreadyHasVirtualCardScreen =
      "/alreadyHasVirtualCardScreen";

  static const String transactionsScreen = '/transactions';
  static const String addMoneyScreen_mtn_momo = '/mtn_momo_add_money';

  static Map<String, WidgetBuilder> get routes => {
        registerScreen: (context) => RegisterScreen(),
        splashScreen: (context) => SplashScreen(),
        walletOnboardingScreen: (context) => WalletOnboardingScreen(),
        transactionHistoryScreen: (context) => TransactionHistoryScreen(),
        connectionLostErrorScreen: (context) => ConnectionLostErrorScreen(),
        paymentsOnboardingScreen: (context) => PaymentsOnboardingScreen(),
        mobileMoneyPaymentScreen: (context) => MobileMoneyPaymentScreen(),
        pinEntryScreen: (context) => PinEntryScreen(),
        addCardDetailsScreen: (context) => AddCardDetailsScreen(),
        loginSuccessScreen: (context) => LoginSuccessScreen(),
        otpVerificationScreen: (context) => OtpVerificationScreen(),
        transactionDetailScreen: (context) => TransactionDetailScreen(),
        initialRoute: (context) => LoginScreen(),
        invalidRecipientErrorScreen: (context) => InvalidRecipientErrorScreen(),
        sendMoneyScreen: (context) => SendMoneyScreen(),
        kycIdentityVerificationScreen: (context) =>
            KycIdentityVerificationScreen(),
        transactionPinConfirmationScreen: (context) =>
            TransactionPinConfirmationScreen(),
        transactionFailedScreen: (context) => TransactionFailedScreen(),
        insufficientFundsScreen: (context) => InsufficientFundsScreen(),
        kycIdentityVerificationScreenTwo: (context) =>
            KycIdentityVerificationScreenTwo(),
        transactionPinConfirmationScreenTwo: (context) =>
            TransactionPinConfirmationScreenTwo(),
        paymentSuccessScreen: (context) => PaymentSuccessScreen(),
        paymentConfirmationScreen: (context) => PaymentConfirmationScreen(),
        home_screen: (context) => DashboardScreen(),
        generate_otp_screen: (context) => GenerateOtpScreen(),
        loginScreen: (context) => LoginScreen(),
        documentUploadScreen: (context) => DocumentUploadScreen(),
        virtualCardPaymentScreen: (context) => VirtualCardPaymentScreen(),
        virtualCardScreen: (context) => VirtualCardSecureWebView(),
        alreadyHasVirtualCardScreen: (context) => AlreadyHasCardScreen(),
        transactionsScreen: (context) => TransactionScreen(),
        addMoneyScreen_mtn_momo: (context) => MomoPayScreen(),
      };
}
