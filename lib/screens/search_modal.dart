import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './camp_detail_screen.dart';

class SearchModal extends StatefulWidget {
  @override
  _SearchModalState createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal> {
  final _searchController = TextEditingController();
  String searchString = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
      height: MediaQuery.of(context).size.height * 0.96,
      child: GestureDetector(
        onDoubleTap: () {
          final FocusScopeNode currentScope = FocusScope.of(context);
          if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: Column(
          children: [
            Container(
              height: 5,
              width: 55,
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    searchString = val.toLowerCase();
                  });
                },
                controller: _searchController,
                autofocus: true,
                cursorColor: Colors.white,
                cursorHeight: 28,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  fontSize: 25,
                ),
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  hintText: 'Search 🔍',
                  hintStyle: TextStyle(
                    color: Colors.white70,
                    fontSize: 25,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).accentColor,
                      style: BorderStyle.solid,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: Scrollbar(
                radius: Radius.circular(10),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chip(
                        avatar: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://media.istockphoto.com/photos/shot-of-a-cute-vintage-teapot-in-a-campsite-near-to-lake-picture-id1305448692?b=1&k=20&m=1305448692&s=170667a&w=0&h=JIAAnIWgx2dwTi96Zn37rauFCRV11EBIPeTbwAjbpPc='),
                        ),
                        label: Text(
                          'Featured ${i + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        elevation: 6,
                        padding: EdgeInsets.all(4),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Search Results',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: (searchString == '' || searchString.trim() == '')
                    ? FirebaseFirestore.instance
                        .collection('camp-details')
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('camp-details')
                        .where('searchIndex', arrayContains: searchString)
                        .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('');
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: Text(''),
                      );
                    case ConnectionState.none:
                      return Center(
                        child: Text(''),
                      );
                    default:
                      var camps = snapshot.data!.docs;
                      return GridView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: camps.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  CampDetail.routeName,
                                  arguments: {
                                    'id': camps[index].id,
                                    'title': camps[index]['title'],
                                    'price': camps[index]['price'],
                                    'description': camps[index]['description'],
                                    'address': camps[index]['address'],
                                    'latitude': camps[index]['loc_lat'],
                                    'longitude': camps[index]['loc_lng'],
                                    'imgUrl': camps[index]['image_url'],
                                    'post_date': camps[index]['cid'],
                                    'post_by': camps[index]['uid']
                                  },
                                );
                              },
                              child: Hero(
                                tag: camps[index].id,
                                child: GridTile(
                                  child: Image.network(
                                    // 'https://media.istockphoto.com/photos/shot-of-a-cute-vintage-teapot-in-a-campsite-near-to-lake-picture-id1305448692?b=1&k=20&m=1305448692&s=170667a&w=0&h=JIAAnIWgx2dwTi96Zn37rauFCRV11EBIPeTbwAjbpPc=',
                                    camps[index]['image_url'],
                                    fit: BoxFit.cover,
                                  ),
                                  footer: GridTileBar(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.84),
                                    title: Text(
                                      camps[index]['title'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                  }
                },
                // child: GridView.builder(
                //   physics: BouncingScrollPhysics(),
                //   padding: const EdgeInsets.all(10),
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     childAspectRatio: 2 / 2,
                //     crossAxisSpacing: 10,
                //     mainAxisSpacing: 10,
                //   ),
                //   itemCount: 10,
                //   itemBuilder: (context, index) {
                //     return ClipRRect(
                //       borderRadius: BorderRadius.circular(10),
                //       child: GestureDetector(
                //         onTap: () {
                //           Navigator.of(context).pushNamed(CampDetail.routeName);
                //         },
                //         child: GridTile(
                //           child: Image.network(
                //             'https://media.istockphoto.com/photos/shot-of-a-cute-vintage-teapot-in-a-campsite-near-to-lake-picture-id1305448692?b=1&k=20&m=1305448692&s=170667a&w=0&h=JIAAnIWgx2dwTi96Zn37rauFCRV11EBIPeTbwAjbpPc=',
                //             fit: BoxFit.cover,
                //           ),
                //           footer: GridTileBar(
                //             backgroundColor: Colors.black.withOpacity(0.84),
                //             title: Text(
                //               'Test ${index + 1}',
                //               style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 17,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
