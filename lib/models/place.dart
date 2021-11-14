import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double? latitude;
  final double? longitude;
  final String? address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}

class Place {
  final String? id;
  final String? title;
  final String? price;
  final String? description;
  final PlaceLocation? location;
  final String? image;

  const Place({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.description,
    @required this.location,
    @required this.image,
  });
}
