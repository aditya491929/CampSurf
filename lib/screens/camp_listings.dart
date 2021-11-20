import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import './camp_detail_screen.dart';
import './search_modal.dart';

class CampListings extends StatefulWidget {
  @override
  _CampListingsState createState() => _CampListingsState();
}

class _CampListingsState extends State<CampListings> {
  void _search(BuildContext cotext) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (bCtx) {
        return SearchModal();
      },
    );
  }

  Future<void> _refreshCamps(BuildContext context) async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference camps =
        FirebaseFirestore.instance.collection('camp-details');
    return GestureDetector(
      onDoubleTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _search(context);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Search 🔍',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: Colors.white70,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _refreshCamps(context),
                color: Theme.of(context).accentColor,
                child: FutureBuilder(
                  future: camps.orderBy('cid', descending: true).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).accentColor,
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Scrollbar(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, i) {
                            final campDoc = snapshot.data!.docs[i];
                            final campId = snapshot.data!.docs[i].id;
                            final address1 = campDoc['address'].split(',');
                            return Hero(
                              tag: campId,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 8,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 6),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                        campDoc['image_url'],
                                      ),
                                    ),
                                    title: Text(
                                      campDoc['title'],
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${address1[3]}, ${address1[4]}',
                                      style: GoogleFonts.karla(),
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        CampDetail.routeName,
                                        arguments: {
                                          'id': campId,
                                          'title': campDoc['title'],
                                          'price': campDoc['price'],
                                          'description': campDoc['description'],
                                          'address': campDoc['address'],
                                          'latitude': campDoc['loc_lat'],
                                          'longitude': campDoc['loc_lng'],
                                          'imgUrl': campDoc['image_url'],
                                          'post_date': campDoc['cid'],
                                          'post_by': campDoc['uid']
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Center(child: Text('No Camps 🙁!'));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
