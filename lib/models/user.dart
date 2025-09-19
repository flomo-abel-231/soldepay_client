class User {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? countryCode;
  final String? phoneNumber;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final DateTime? dateOfBirth;
  final String? govtIdNumber;
  final String? gender;
  final String? title;


  User({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.countryCode,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.dateOfBirth,
    this.govtIdNumber,
    this.gender,
    this.title,
    
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password:
          json['password'], // Include only when needed (e.g. login/register)
      countryCode: json['countryCode'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postalCode'],
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.tryParse(json['dateOfBirth'])
          : null,
      govtIdNumber: json['govtIdNumber'],
      gender: json['gender'],
      title: json['title'],
    
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'govtIdNumber': govtIdNumber,
      'gender': gender,
      'title': title,
      
    };
  }
}
