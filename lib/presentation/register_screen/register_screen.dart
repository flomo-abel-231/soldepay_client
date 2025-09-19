import 'package:country_picker/country_picker.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../services/user_service.dart';
import '../../models/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKeyStep1 = GlobalKey<FormState>();
  final _formKeyStep2 = GlobalKey<FormState>();

  int _step = 1;
  final _userService = UserService();

  // Step 1 Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Step 2 Controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();
  final _countryCodeController = TextEditingController(); // ISO 2-letter code
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _govtIdController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _titleController = TextEditingController();

  DateTime? _dob;
  String? _selectedGender;

  late List<Country> countries;

  @override
  void initState() {
    super.initState();
    countries = CountryService().getAll(); // Initialize country list here
  }

  void _pickDateOfBirth() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _dob = picked);
    }
  }

  void _submitStep1() {
    if (_formKeyStep1.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")),
        );
        return;
      }
      setState(() => _step = 2);
    }
  }

  void _register() async {
    if (_formKeyStep2.currentState!.validate()) {
      User user = User(
        email: _emailController.text,
        password: _passwordController.text,
        phoneNumber: _phoneController.text,
        countryCode: _countryCodeController.text,
        country: _countryController.text,
        state: _stateController.text,
        city: _cityController.text,
        address: _addressController.text,
        govtIdNumber: _govtIdController.text,
        postalCode: _postalCodeController.text,
        title: _titleController.text,
        gender: _selectedGender,
        dateOfBirth: _dob,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
      );

      try {
        final response = await _userService.registerUser(user);
        if (response.statusCode == 200 || response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${response.body}")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed: ${response.body}")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred: $e")),
        );
      }
    }
  }

  List<Country> get countryList => countries;

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: false, // only show ISO codes like "US", "NG", etc.
      onSelect: (Country country) {
        setState(() {
          _countryCodeController.text = country.countryCode; // e.g. "US"
        });
      },
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgGroupDeepPurple90002,
              height: 32.h,
              width: 29.h,
            ),
            const SizedBox(width: 8),
            CustomImageView(
              imagePath: ImageConstant.imgGroup26x110,
              height: 26.h,
              width: 110.h,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          "Register for SoldePay",
          style: TextStyleHelper.instance.headline26BoldPoppins
              .copyWith(color: Colors.white),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          color: appTheme.colorFF0908,
          image: DecorationImage(
            image: AssetImage(ImageConstant.imgEllipse78),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: MediaQuery.of(context).size.height * 0.015,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHeader(),
                        _step == 1 ? _buildStep1() : _buildStep2(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return Form(
      key: _formKeyStep1,
      child: Column(
        children: [
          _styledField(_emailController, "Email"),
          _styledField(_passwordController, "Password", obscureText: true),
          _styledField(_confirmPasswordController, "Confirm Password",
              obscureText: true),
          const SizedBox(height: 20),
          CustomButton(
            text: "Next",
            buttonType: CustomButtonType.gradient,
            height: 53.h,
            fontSize: 16.fSize,
            onPressed: _submitStep1,
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return Form(
      key: _formKeyStep2,
      child: Column(
        children: [
          _styledField(_firstNameController, "First Name"),
          _styledField(_lastNameController, "Last Name"),
          IntlPhoneField(
            decoration: const InputDecoration(
              labelText: "Phone Number",
              labelStyle: TextStyle(color: Colors.white),
            ),
            initialCountryCode: 'LR',
            style: const TextStyle(color: Colors.white),
            dropdownTextStyle: const TextStyle(color: Colors.black),
            onChanged: (phone) {
              _phoneController.text = phone.completeNumber;
            },
          ),
          Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.black,
              textTheme: const TextTheme(
                titleMedium: TextStyle(color: Colors.white),
              ),
            ),
            child: SelectState(
              style: const TextStyle(color: Colors.white),
              dropdownColor: Colors.black,
              onCountryChanged: (value) {
                setState(() {
                  _countryController.text = value;
                });
              },
              onStateChanged: (value) => _stateController.text = value,
              onCityChanged: (value) => _cityController.text = value,
            ),
          ),
          _styledField(_addressController, "Address"),
          _styledField(_postalCodeController, "Postal Code"),
          _styledField(_govtIdController, "Govt ID Number"),
          _styledDropdown(
            label: "Gender",
            value: _selectedGender,
            items: ['Male', 'Female'],
            onChanged: (val) => setState(() => _selectedGender = val),
          ),
          _styledDropdown(
            label: "Title",
            value:
                _titleController.text.isNotEmpty ? _titleController.text : null,
            items: ['Mr', 'Mrs', 'Miss', 'Dr'],
            onChanged: (val) => setState(() => _titleController.text = val!),
          ),
          InkWell(
            onTap: _showCountryPicker,
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.white),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _countryCodeController.text.isNotEmpty
                        ? _countryCodeController.text.toUpperCase()
                        : 'Select Country Code',
                    style: TextStyle(
                      color: _countryCodeController.text.isNotEmpty
                          ? Colors.white
                          : Colors.white54,
                      fontSize: 16,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Date of Birth: ${_dob != null ? _dob!.toLocal().toString().split(' ')[0] : "Not selected"}",
              style: const TextStyle(color: Colors.white),
            ),
            trailing: const Icon(Icons.calendar_today, color: Colors.white),
            onTap: _pickDateOfBirth,
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: "Submit Registration",
            buttonType: CustomButtonType.gradient,
            height: 53.h,
            fontSize: 16.fSize,
            onPressed: _register,
          ),
        ],
      ),
    );
  }

  Widget _styledField(TextEditingController controller, String label,
      {bool obscureText = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
          validator: (value) => value!.isEmpty ? "Enter $label" : null,
        ),
      ),
    );
  }

  Widget _styledDropdown({
    required String label,
    required List<String> items,
    required Function(String?) onChanged,
    String? value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items
            .map((item) =>
                DropdownMenuItem<String>(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
        dropdownColor: Colors.black,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          border: InputBorder.none,
        ),
        validator: (value) => value == null ? "Select $label" : null,
      ),
    );
  }
}
