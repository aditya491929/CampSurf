import 'package:flutter/material.dart';
import './camp_detail_screen.dart';

class CampListings extends StatefulWidget {
  @override
  _CampListingsState createState() => _CampListingsState();
}

class _CampListingsState extends State<CampListings> {

  @override
  Widget build(BuildContext context) {
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
            // GestureDetector(
            //   onTap: () {
            //     _renderShowModal();
            //   },
            //   child: Container(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            //     margin:
            //         const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       border: Border.all(width: 2, color: Colors.grey),
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Text(
            //       'Search 🔍',
            //       style: TextStyle(
            //         color: Colors.white70,
            //         fontSize: 25,
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, i) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 8,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            'https://media.istockphoto.com/photos/shot-of-a-cute-vintage-teapot-in-a-campsite-near-to-lake-picture-id1305448692?b=1&k=20&m=1305448692&s=170667a&w=0&h=JIAAnIWgx2dwTi96Zn37rauFCRV11EBIPeTbwAjbpPc='),
                      ),
                      title: Text(
                        'Test ${i + 1}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Location ${i + 1}',
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(CampDetail.routeName);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
