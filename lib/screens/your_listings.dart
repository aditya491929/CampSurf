import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './tabs_screen.dart';
import './edit_screen.dart';
import './camp_detail_screen.dart';

class YourListings extends StatefulWidget {
  static const routeName = '/yourPosts';
  @override
  _YourListingsState createState() => _YourListingsState();
}

class _YourListingsState extends State<YourListings> {
  Future<void> _refreshCamps(BuildContext context) async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;
    // print(user?.uid);

    var myCamps = FirebaseFirestore.instance.collection('camp-details')
      .where('uid', isEqualTo: 
      user?.uid)
      // 'HS4K4j1k4SO50QruezngGCCsT3k1')
      ;
    inspect(myCamps.get());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
          },
        ),
        title: Row(
          children: [
            SizedBox(
              width: 25,
            ),
            SizedBox(
              height: 70,
              width: 70,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 1,
            ),
            RichText(
              text: TextSpan(
                text: 'Camp',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: 'Surf',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 5, top: 10, right: 5),
        child: Column(
          children: [
            Text(
              '📃 Listed Camps',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _refreshCamps(context),
                color: Theme.of(context).accentColor,
                child: FutureBuilder(
                  future: myCamps.get(),//.orderBy('cid', descending: true).get(),
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
                      if (snapshot.data!.docs.length != 0) {

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
                                    trailing: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(EditScreen.routeName);
                                      },
                                      icon: Icon(
                                        Icons.edit_outlined,
                                        color: Theme.of(context).accentColor,
                                      ),
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
                      else {
                        return Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '🙁',
                                  style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(''),
                                Text('You have not listed any Camps!'),
                              ],
                          ) 
                        );
                      }
                    }
                    return Text('');
                  },
                ),
              ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     physics: BouncingScrollPhysics(),
            //     itemCount: 10,
            //     itemBuilder: (context, i) => Card(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       elevation: 8,
            //       margin:
            //           const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
            //       child: Padding(
            //         padding: const EdgeInsets.all(8),
            //         child: ListTile(
            //           leading: CircleAvatar(
            //             radius: 30,
            //             backgroundImage: NetworkImage(
            //                 'https://media.istockphoto.com/photos/shot-of-a-cute-vintage-teapot-in-a-campsite-near-to-lake-picture-id1305448692?b=1&k=20&m=1305448692&s=170667a&w=0&h=JIAAnIWgx2dwTi96Zn37rauFCRV11EBIPeTbwAjbpPc='),
            //           ),
            //           title: Text(
            //             'Listed Camp ${i + 1}',
            //             style: TextStyle(
            //               fontSize: 20,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           subtitle: Text(
            //             'Location ${i + 1}',
            //           ),
            //           trailing: IconButton(
            //             onPressed: () {
            //               Navigator.of(context).pushNamed(EditScreen.routeName);
            //             },
            //             icon: Icon(
            //               Icons.edit_outlined,
            //               color: Theme.of(context).accentColor,
            //             ),
            //           ),
            //           onTap: () {
            //             Navigator.of(context).pushNamed(CampDetail.routeName);
            //           },
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
