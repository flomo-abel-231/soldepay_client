class OtpRequest {
  final String identifier;

  OtpRequest(
    {
      required this.identifier
      }
    );

  Map<String, dynamic> toJson() => {
    'identifier': identifier,
  };
}
