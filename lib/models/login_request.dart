class LoginRequest {
  final String identifier;
  final String password;
  final String otp;

  LoginRequest({
    required this.identifier,
    required this.password,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
        'identifier': identifier,
        'password': password,
        'otp': otp,
      };
}
