import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/mapPage';

  // MapScreen(
  //     {this.initialLocation =
  //         const PlaceLocation(latitude: 37.422, longitude: -122.084),
  //     this.isSelecting = false});

  final initialLatitude = 20.5937;
  final initialLongitude = 78.9629;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(
            widget.initialLatitude,
            widget.initialLongitude,
          ),
          zoom: 5.0,
          onTap: null,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/aditya929/ckrord83sdff417qyw2k1owlm/tiles/256/{z}/{x}/{y}@2x?access_token=${dotenv.env['ACCESS_TOKEN']}",
              additionalOptions: {
                'accessToken': '${dotenv.env["ACCESS_TOKEN"]}',
                'id': 'mapbox.mapbox-streets-v8',
              }),
          MarkerLayerOptions(
            markers: []
          ),
        ],
      ),
    );
  }
}
