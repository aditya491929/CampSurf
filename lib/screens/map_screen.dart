import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'camp_detail_screen.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/mapPage';

  final initialLatitude = 20.5937;
  final initialLongitude = 78.9629;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  void _showData(camp, campId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Color.fromRGBO(40, 40, 40, 1),
        content: Container(
          padding: EdgeInsets.all(0),
          height: MediaQuery.of(context).size.height * 0.27,
          width: double.infinity,
          child: Row(
            children: [
              Container(
                height: 180,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(48, 48, 48, 1),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    camp['image_url'], 
                    fit: BoxFit.cover, 
                    width: double.infinity,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.05,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      camp['title'],
                      style: GoogleFonts.lato( 
                          textStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Price: ',
                      style: GoogleFonts.karla(
                          textStyle: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 7),
                      label: Text(
                        '\$ ${camp['price']} / night',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Text('')),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        Navigator.of(context).pushNamed(
                          CampDetail.routeName,
                          arguments: {
                            'id': campId,
                            'title': camp['title'],
                            'price': camp['price'],
                            'description': camp['description'],
                            'address': camp['address'],
                            'latitude': camp['loc_lat'],
                            'longitude': camp['loc_lng'],
                            'imgUrl': camp['image_url'],
                            'post_date': camp['cid'],
                            'post_by': camp['uid']
                          },
                        );
                      }, 
                      child: Text(
                        'More Info', 
                        style: GoogleFonts.karla(
                            textStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.amber),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )
                        )
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference campDetails =
        FirebaseFirestore.instance.collection('camp-details');
    return StreamBuilder<QuerySnapshot>(
      stream: campDetails.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).accentColor,
            ),
          );
        }
        if (snapshot.hasData) {
          final campsData = snapshot.data!.docs;
          List<Marker> markersData = [];
          for (int i = 0; i < campsData.length; i++) {
            markersData.add(
              Marker(
                anchorPos: AnchorPos.exactly(Anchor(0.5, 1)),
                width: 40.0,
                height: 40.0,
                point: latLng.LatLng(
                    campsData[i]['loc_lat'], campsData[i]['loc_lng']),
                builder: (ctx) => Container(
                  child: IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      _showData(campsData[i], campsData[i].id);
                    },
                    icon: Icon(Icons.location_on),
                    color: Colors.red,
                    iconSize: 40.0,
                  ),
                ),
              ),
            );
          }
          return Container(
            child: FlutterMap(
              options: MapOptions(
                center: latLng.LatLng(
                  widget.initialLatitude,
                  widget.initialLongitude,
                ),
                zoom: 5.0,
                onTap: null,
                plugins: [
                  MarkerClusterPlugin(),
                ],
              ),
              layers: [
                TileLayerOptions(
                    urlTemplate:
                        "https://api.mapbox.com/styles/v1/aditya929/ckrord83sdff417qyw2k1owlm/tiles/256/{z}/{x}/{y}@2x?access_token=${dotenv.env['ACCESS_TOKEN']}",
                    additionalOptions: {
                      'accessToken': '${dotenv.env["ACCESS_TOKEN"]}',
                      'id': 'mapbox.mapbox-streets-v8',
                    }),
                MarkerClusterLayerOptions(
                  maxClusterRadius: 120,
                  size: Size(40, 40),
                  fitBoundsOptions: FitBoundsOptions(
                    padding: const EdgeInsets.all(50),
                  ),
                  markers: markersData,
                  polygonOptions: PolygonOptions(
                    borderColor: Colors.amberAccent,
                    color: Colors.black12,
                    borderStrokeWidth: 3,
                  ),
                  builder: (context, markers) {
                    return FloatingActionButton(
                      backgroundColor: Theme.of(context).accentColor,
                      child: Text(markersData.length.toString()),
                      onPressed: null,
                    );
                  },
                ),
                MarkerLayerOptions(markers: markersData),
              ],
            ),
          );
        }
        return Center(
          child: Center(
            child: Text('Something Went Wrong 🙁!'),
          ),
        );
      },
    );
  }
}
