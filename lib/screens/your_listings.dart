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

    var myCamps = FirebaseFirestore.instance
        .collection('camp-details')
        .where('uid', isEqualTo: user?.uid);

    void _deleteCamp(String id) async {
      await FirebaseFirestore.instance
          .collection('camp-details')
          .doc(id)
          .delete();
      setState(() {});
    }

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
                  future:
                      myCamps.get(), //.orderBy('cid', descending: true).get(),
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
                              final campId = snapshot.data!.docs[i].id;
                              final address1 = campDoc['address'].split(',');
                              return Dismissible(
                                key: ValueKey(campId),
                                background: Container(
                                  color: Theme.of(context).errorColor,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 4,
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 20),
                                ),
                                direction: DismissDirection.endToStart,
                                confirmDismiss: (direction) {
                                  return showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text('Are you sure?'),
                                      content: Text(
                                          'Do you want to remove the item from the cart?'),
                                      actions: [
                                        TextButton(
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontSize: 18,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(ctx).pop(false);
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            'Remove',
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontSize: 18,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(ctx).pop(true);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                onDismissed: (direction) {
                                  _deleteCamp(campId);
                                },
                                child: Hero(
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
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                          '${address1[(address1.length) - 2]}, ${address1[(address1.length) - 1]}',
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                EditScreen.routeName,
                                                arguments: {
                                                  'cid': campId,
                                                  'title': campDoc['title'],
                                                  'price': campDoc['price'],
                                                  'description':
                                                      campDoc['description'],
                                                });
                                          },
                                          icon: Icon(
                                            Icons.edit_outlined,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                            CampDetail.routeName,
                                            arguments: {
                                              'id': campId,
                                              'title': campDoc['title'],
                                              'price': campDoc['price'],
                                              'description':
                                                  campDoc['description'],
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
                                ),
                              );
                            },
                          ),
                        );
                      } else {
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
                        ));
                      }
                    }
                    return Text('');
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
