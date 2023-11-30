class GardenInfo {
  String name;
  String phoneNumber;
  String address;
  String briefHistory;
  List<String> socialMediaLinks;

  GardenInfo({
    required this.id,
    required this.phoneNumber,
    required this.address,
    required this.briefHistory,
    required this.socialMediaLinks,
  });

  Map<String, dynamic> toMap() {
    return {
      
      'id': id,
      'phoneNumber': phoneNumber,
      'address': address,
      'briefHistory': briefHistory,
      'socialMediaLinks': socialMediaLinks,
    };
  }

  
  factory GardenInfo.fromMap(Map<String, dynamic> map) {
    return GardenInfo(
      id: map['id'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      briefHistory: map['briefHistory'] ?? '',
      socialMediaLinks: List<String>.from(map['socialMediaLinks'] ?? []),
    );
  }
}
