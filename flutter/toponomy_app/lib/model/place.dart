class Place {
  int id;
  String ownerId;
  String placeName;
  String address;
  String placeType;
  DateTime date;
  bool isDeleted;
  double latitude;
  double longitude;

  Place({
    required this.id,
    required this.ownerId,
    required this.placeName,
    required this.address,
    required this.placeType,
    required this.date,
    required this.isDeleted,
    required this.latitude,
    required this.longitude,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['Id'] as int,
      ownerId: json['OwnerId'] as String,
      placeName: json['PlaceName'] as String,
      address: json['Address'] as String,
      placeType: json['PlaceType'] as String,
      date: DateTime.parse(json['Date'] as String),
      isDeleted: json['IsDeleted'] as bool,
      latitude: json['Latitude'] as double,
      longitude: json['Longitude'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'OwnerId': ownerId,
      'PlaceName': placeName,
      'Address': address,
      'PlaceType': placeType,
      'Date': date.toIso8601String(),
      'IsDeleted': isDeleted,
      'Latitude': latitude,
      'Longitude': longitude,
    };
  }
}
