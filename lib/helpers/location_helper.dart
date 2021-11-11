import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


final accessToken = dotenv.env['ACCESS_TOKEN'];

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/outdoors-v11/static/pin-s+ee2f2f($longitude,$latitude)/$longitude,$latitude,13,0,60/400x400?access_token=$accessToken';
  }
}