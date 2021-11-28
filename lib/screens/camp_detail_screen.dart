import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import './location_screen.dart';
import '../models/place.dart';
import '../helpers/location_helper.dart';

class CampDetail extends StatefulWidget {
  static const routeName = '/campDetail';
  @override
  _CampDetailState createState() => _CampDetailState();
}

class _CampDetailState extends State<CampDetail> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final _campDetails = {
      'id': routeArgs['id'],
      'title': routeArgs['title'],
      'price': routeArgs['price'],
      'description': routeArgs['description'],
      'address': routeArgs['address'],
      'latitude': routeArgs['latitude'],
      'longitude': routeArgs['longitude'],
      'imgUrl': routeArgs['imgUrl'],
      'post_date': routeArgs['post_date'],
      'post_by': routeArgs['post_by']
    };
    final _imagePreviewUrl = LocationHelper.generateLocationPreviewImage(
        latitude: _campDetails['latitude'],
        longitude: _campDetails['longitude']);
    final userRef = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).accentColor,
                size: 30,
              ),
            ),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Hero(
                tag: _campDetails['id'],
                child: SizedBox(
                  child: Image.network(
                    _campDetails['imgUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                _campDetails['title'],
                style: GoogleFonts.lato(),
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_outline,
                    color: Theme.of(context).accentColor,
                    size: 30,
                  )),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              _campDetails['title'],
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  fontSize: 33,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                            ),
                          ),
                          Expanded(child: Text('')),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: FutureBuilder(
                              future:
                                  userRef.doc(_campDetails['post_by']).get(),
                              builder: (BuildContext ctx, snapShot) {
                                if (snapShot.connectionState ==
                                    ConnectionState.done) {
                                  DocumentSnapshot<Object?> data =
                                      snapShot.data! as DocumentSnapshot;
                                  return Chip(
                                    label: Text(
                                      '- ${data['username']}',
                                      style: GoogleFonts.karla(
                                        textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                                  );
                                }
                                return Text('');
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Price: ',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 23,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Chip(
                          labelPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          label: Text(
                            '\$ ${_campDetails['price']} / night',
                            style: GoogleFonts.karla(
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Description: ',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 23,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _campDetails['description'],
                          style: GoogleFonts.karla(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          softWrap: true,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Address: ',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 23,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _campDetails['address'],
                          style: GoogleFonts.karla(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Location: ',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 23,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            _imagePreviewUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (ctx) => LocationScreen(
                                  initialLocation: PlaceLocation(
                                    latitude: _campDetails['latitude'],
                                    longitude: _campDetails['longitude'],
                                  ),
                                  isSelecting: false,
                                  location: _campDetails['address']),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'View on Map 🗺️',
                            style: GoogleFonts.karla(
                              textStyle: TextStyle(
                                color: Color.fromRGBO(48, 48, 48, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).accentColor),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Posted On: ',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 23,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Chip(
                        label: Text(
                          '${_campDetails['post_date'].split(' ')[0]}',
                          style: GoogleFonts.karla(
                            textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          //     child: ClipRRect(
          //       borderRadius: BorderRadius.circular(10),
          //       child: Container(
          //         height: 400,
          //         color: Colors.grey[600],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
