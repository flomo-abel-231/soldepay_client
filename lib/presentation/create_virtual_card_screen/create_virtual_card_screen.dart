import 'dart:convert';

import 'package:flutter/material.dart' hide Card;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soldepay/presentation/payment_success_screen/payment_success_screen.dart';

import '../../core/app_export.dart';
import '../../services/virtual_card_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';

class VirtualCardPaymentScreen extends StatefulWidget {
  const VirtualCardPaymentScreen({Key? key}) : super(key: key);

  @override
  State<VirtualCardPaymentScreen> createState() =>
      _VirtualCardPaymentScreenState();
}

class _VirtualCardPaymentScreenState extends State<VirtualCardPaymentScreen> {
  final double _fixedAmount = 9.0;
  final TextEditingController _momoController = TextEditingController();
  final VirtualCardService virtualCardService = VirtualCardService();

  String? _selectedPaymentMethod;
  bool _loading = false;
  String? _error;

  String? firstName;
  String? lastName;
  String? email;
  String? address;
  String? phoneNumber;

  bool _checkingCardStatus = true;

  @override
  void initState() {
    super.initState();
    debugPrint("[VirtualCardPaymentScreen] initState called");
    _loadRememberedCredentials();
    _initializeStripe();
    _checkIfUserHasCard();
  }

  Future<void> _initializeStripe() async {
    debugPrint("[VirtualCardPaymentScreen] Initializing Stripe...");
    try {
      Stripe.publishableKey =
          "pk_test_51KMJ77LKpApIlLNtNnuJrrxMozOM15F2dnrIFdWLAO9kJAXCak85JlAijNhZi34kQKviKeyxOs0tgBLYADQ3J3RI00T5vH2Q08";
      await Stripe.instance.applySettings();
      debugPrint("[VirtualCardPaymentScreen] Stripe initialized successfully");
    } catch (e) {
      debugPrint("[VirtualCardPaymentScreen] Stripe init failed: $e");
    }
  }

  Future<void> _checkIfUserHasCard() async {
    debugPrint("[VirtualCardPaymentScreen] Checking if user has a card...");
    setState(() {
      _checkingCardStatus = true;
    });

    try {
      bool hasCard = await virtualCardService.checkUserHasCard();
      debugPrint("[VirtualCardPaymentScreen] User has card: $hasCard");

      if (hasCard && mounted) {
        debugPrint(
            "[VirtualCardPaymentScreen] Navigating to AlreadyHasVirtualCardScreen...");
        Navigator.of(context)
            .pushReplacementNamed(AppRoutes.alreadyHasVirtualCardScreen);
      }
    } catch (e) {
      debugPrint("[VirtualCardPaymentScreen] Error checking card status: $e");
      setState(() {
        _error = 'Failed to verify card status: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() {
          _checkingCardStatus = false;
        });
      }
    }
  }

  Future<void> _loadRememberedCredentials() async {
    debugPrint("[VirtualCardPaymentScreen] Loading remembered credentials...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName') ?? '';
      lastName = prefs.getString('lastName') ?? '';
      email = prefs.getString('email') ?? '';
      address = prefs.getString('address') ?? '';
      phoneNumber = prefs.getString('phoneNumber') ?? '';
    });
    debugPrint(
        "[VirtualCardPaymentScreen] Loaded user: $firstName $lastName, Email: $email");
  }

  Future<String> _fetchClientSecret() async {
    debugPrint("[VirtualCardPaymentScreen] Fetching client secret...");
    final token = (await virtualCardService.getToken()).trim();
    debugPrint("[VirtualCardPaymentScreen] Using auth token: $token");

    final response = await http.post(
      Uri.parse(
          '${virtualCardService.baseUrl}/stripe-payment/stripe-payment-intent'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"amount": _fixedAmount}),
    );

    debugPrint(
        "[VirtualCardPaymentScreen] Stripe client secret response: ${response.body}");

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      debugPrint(
          "[VirtualCardPaymentScreen] Received clientSecret: ${json['clientSecret']}");
      return json['clientSecret'];
    } else {
      throw Exception('Failed to fetch payment intent');
    }
  }

  Future<void> _payWithStripe() async {
    debugPrint("[VirtualCardPaymentScreen] Initiating Stripe payment...");
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      // Step 1: Check again if user already has a card
      bool hasCard = await virtualCardService.checkUserHasCard();
      if (hasCard) {
        debugPrint(
            "[VirtualCardPaymentScreen] User already has a card. Redirecting...");
        Navigator.of(context).pushNamed(AppRoutes.alreadyHasVirtualCardScreen);
        return;
      }

      // Step 2: Get client secret
      debugPrint(
          "[VirtualCardPaymentScreen] Step 2: Fetching client secret...");
      final clientSecret = await _fetchClientSecret();

      // Step 3: Initialize Stripe payment sheet
      debugPrint(
          "[VirtualCardPaymentScreen] Step 3: Initializing Stripe payment sheet...");
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Soldepay',
          style: ThemeMode.dark,
          billingDetails: BillingDetails(
            email: email,
            name: '$firstName $lastName',
            phone: phoneNumber,
          ),
        ),
      );

      // Step 4: Present payment sheet
      debugPrint(
          "[VirtualCardPaymentScreen] Step 4: Presenting payment sheet...");
      await Stripe.instance.presentPaymentSheet();

      // Step 5: Create customer & card
      debugPrint(
          "[VirtualCardPaymentScreen] Step 5: Creating customer & card via backend...");
      final createCustomerResponse = await virtualCardService.createCustomer();
      final createCardResponse = await virtualCardService.createCard({
        'paymentMethod': 'Bank Card',
        'clientSecret': clientSecret,
        'amount': _fixedAmount,
      });

      if ((createCustomerResponse.statusCode == 200 ||
              createCustomerResponse.statusCode == 201) &&
          (createCardResponse.statusCode == 200 ||
              createCardResponse.statusCode == 201)) {
        debugPrint(
            "[VirtualCardPaymentScreen] Card creation successful. Navigating to success screen.");
        _navigateToSuccessScreen();
      } else if (createCardResponse.body.contains("User has existing card.")) {
        debugPrint(
            "[VirtualCardPaymentScreen] Redirecting to AlreadyHasVirtualCardScreen...");
        Navigator.of(context).pushNamed(AppRoutes.alreadyHasVirtualCardScreen);
      } else {
        debugPrint(
            "[VirtualCardPaymentScreen] Card creation failed. Status code: ${createCardResponse.statusCode}, Body: ${createCardResponse.body}");
        setState(() {
          _error = "Failed to create card.";
        });
      }

      setState(() => _selectedPaymentMethod = null);
    } on StripeException catch (e) {
      debugPrint(
          "[VirtualCardPaymentScreen] Stripe error: ${e.error.localizedMessage}");
      setState(() {
        _error = e.error.code == FailureCode.Canceled
            ? 'Payment cancelled by user.'
            : 'Stripe error: ${e.error.localizedMessage}';
      });
    } catch (e) {
      debugPrint(
          "[VirtualCardPaymentScreen] Unexpected error during Stripe payment: $e");
      setState(() => _error = 'Error: ${e.toString()}');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _payWithMomo() async {
    debugPrint("[VirtualCardPaymentScreen] Initiating MoMo payment...");
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final momoNumber = _momoController.text.trim();
      if (momoNumber.isEmpty) {
        debugPrint(
            "[VirtualCardPaymentScreen] MoMo number is empty. Aborting...");
        throw Exception("Please enter your MoMo number.");
      }

      // Step 1: Check if user already has a card
      debugPrint(
          "[VirtualCardPaymentScreen] Step 1: Checking if user already has a card...");
      bool hasCard = await virtualCardService.checkUserHasCard();
      if (hasCard) {
        debugPrint(
            "[VirtualCardPaymentScreen] User already has a card. Redirecting...");
        Navigator.of(context).pushNamed(AppRoutes.alreadyHasVirtualCardScreen);
        return;
      }

      // Step 2: Create customer and card
      debugPrint(
          "[VirtualCardPaymentScreen] Step 2: Creating customer and card via MoMo...");
      await virtualCardService.createCustomer();
      await virtualCardService.createCard({
        'paymentMethod': 'MTN Mobile Money',
        'momoNumber': momoNumber,
        'amount': _fixedAmount,
      });

      debugPrint(
          "[VirtualCardPaymentScreen] MoMo payment successful. Navigating to success screen.");
      _navigateToSuccessScreen();
      setState(() => _selectedPaymentMethod = null);
      _momoController.clear();
    } catch (e) {
      debugPrint("[VirtualCardPaymentScreen] Error during MoMo payment: $e");
      setState(() => _error = 'Error: ${e.toString()}');
    } finally {
      setState(() => _loading = false);
    }
  }

  void _navigateToSuccessScreen() {
    debugPrint(
        "[VirtualCardPaymentScreen] Navigating to Payment Success Screen...");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentSuccessScreen(
          recipientName: firstName ?? "",
          amount: _fixedAmount,
          transactionId: "TXN${DateTime.now().millisecondsSinceEpoch}",
          date: DateFormat('MMM dd, yyyy').format(DateTime.now()),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required String iconPath,
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
          CustomImageView(
            imagePath: iconPath,
            height: 20.h,
            width: 20.h,
          ),
          SizedBox(width: 12.h),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              style: TextStyleHelper.instance.title16Poppins
                  .copyWith(color: appTheme.whiteCustom),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyleHelper.instance.title16Poppins,
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(width: 20.h),
        ],
      ),
    );
  }

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
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 100.h, bottom: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Confirm Payment',
                style: TextStyleHelper.instance.title16Poppins
                    .copyWith(color: appTheme.whiteCustom, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),

              // Show error if exists
              if (_error != null)
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.redAccent),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Show loading spinner if checking card
              if (_checkingCardStatus)
                const Center(child: CircularProgressIndicator())
              else
                Column(
                  children: [
                    // Stripe (Bank Card) button
                    CustomButton(
                      text: 'Pay with Bank Card',
                      onPressed: () {
                        setState(() {
                          _selectedPaymentMethod = 'stripe';
                        });
                        _payWithStripe();
                      },
                      buttonType: CustomButtonType.gradient,
                      height: 53.h,
                      borderRadius: 26,
                    ),
                    SizedBox(height: 16.h),

                    // MoMo button
                    CustomButton(
                      text: 'Pay with MTN MoMo',
                      onPressed: () {
                        setState(() {
                          _selectedPaymentMethod = 'momo';
                        });
                      },
                      buttonType: CustomButtonType.gradient,
                      height: 53.h,
                      borderRadius: 26,
                    ),

                    // Conditional MoMo number input
                    if (_selectedPaymentMethod == 'momo') ...[
                      SizedBox(height: 24.h),
                      _buildInputField(
                        controller: _momoController,
                        hintText: 'Enter MTN MoMo Number',
                        iconPath: ImageConstant.imgCall,
                      ),
                      SizedBox(height: 16.h),
                      CustomButton(
                        text: 'Confirm MoMo Payment',
                        onPressed: _payWithMomo,
                        buttonType: CustomButtonType.gradient,
                        height: 53.h,
                        borderRadius: 26,
                      ),
                    ],
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
