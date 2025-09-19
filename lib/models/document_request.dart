class DocumentRequest {
  final String passportSizePhoto;
  final String passportOrGovernmentIdFront;
  final String passportOrGovernmentIdBack;

  DocumentRequest({
    required this.passportSizePhoto,
    required this.passportOrGovernmentIdBack,
    required this.passportOrGovernmentIdFront,
  });

  Map<String, dynamic> toJson() => {
        "passportSizePhoto": passportSizePhoto,
        "passportOrGovernmentIdBack": passportOrGovernmentIdBack,
        "passportOrGovernmentIdFront": passportOrGovernmentIdFront,
      };
}
