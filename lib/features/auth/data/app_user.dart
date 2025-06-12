class AppUser {
  final String email;
  final String region;
  final String industry;
  final String businessType;
  final String businessSize;
  final String gender;

  AppUser({
    required this.email,
    required this.region,
    required this.industry,
    required this.businessType,
    required this.businessSize,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'region': region,
      'industry': industry,
      'businessType': businessType,
      'businessSize': businessSize,
      'gender': gender,
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      email: json['email'],
      region: json['region'],
      industry: json['industry'],
      businessType: json['businessType'],
      businessSize: json['businessSize'],
      gender: json['gender'],
    );
  }
}
