import 'dart:developer';

import 'package:flutter/material.dart';
import './camp_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CampListings extends StatefulWidget {
  @override
  _CampListingsState createState() => _CampListingsState();
}

class _CampListingsState extends State<CampListings> {

  Future<void> _refreshCamps(BuildContext context) async {
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {

    CollectionReference camps = FirebaseFirestore.instance.collection('camp-details');
    print("db data: ");
    inspect(camps.get());
    
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
                            final address1 = campDoc['address'].split(',');
                            return Card(
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
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${address1[3]}, ${address1[4]}',
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(CampDetail.routeName);
                                  },
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
