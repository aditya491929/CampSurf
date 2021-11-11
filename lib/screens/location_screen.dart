import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/place.dart';

class LocationScreen extends StatefulWidget {
  static const routeName = 'location-screen';
  final PlaceLocation initialLocation;
  final bool isSelecting;

  LocationScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 20.5937, longitude: 78.9629),
      this.isSelecting = false});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  latLng.LatLng? _pickedLocation;
  final accessToken = dotenv.env['ACCESS_TOKEN'];
  
  void _selectLocation(dynamic tapPosition, latLng.LatLng? position) {
    print(tapPosition);
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: Icon(Icons.check),
            ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(
            widget.initialLocation.latitude!,
            widget.initialLocation.longitude!,
          ),
          zoom: 5.0,
          onTap: widget.isSelecting ? _selectLocation : null,
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
            markers: (_pickedLocation == null && widget.isSelecting)
                ? []
                : [
                    Marker(
                      width: 45.0,
                      height: 45.0,
                      point: _pickedLocation ??
                          latLng.LatLng(widget.initialLocation.latitude!,
                              widget.initialLocation.longitude!),
                      builder: (ctx) => Container(
                        child: IconButton(
                          onPressed: () {
                            print('Marker tapped');
                          },
                          icon: Icon(Icons.location_on),
                          color: Colors.red,
                          iconSize: 45.0,
                        ),
                      ),
                    ),
                  ],
          ),
        ],
      ),
    );
  }
}
