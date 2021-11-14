import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


final accessToken = dotenv.env['ACCESS_TOKEN'];

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/outdoors-v11/static/pin-s+ee2f2f($longitude,$latitude)/$longitude,$latitude,13,0,60/400x400?access_token=$accessToken';
  }

  static Future<String> getCampAddress(double? lat, double? lng) async {
    final url = Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$lng,$lat.json?access_token=$accessToken');

    final response = await http.get(url);
    print(json.decode(response.body));
    return json.decode(response.body)['features'][0]['place_name'];
  }
}