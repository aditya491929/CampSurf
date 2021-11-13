import 'package:flutter/material.dart';
<<<<<<< HEAD

class SearchModal extends StatefulWidget {
=======
import './camp_detail_screen.dart';


class SearchModal extends StatefulWidget {

  // final String query;

  // SearchModal({required this.query});

>>>>>>> f6ee7d3cdc703eab2e8aca40dbaaa2343840a904
  @override
  _SearchModalState createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
<<<<<<< HEAD
        padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            Container(
              height: 5,
              width: 55,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(10)
              ),
            ),
          ],
        ),
=======
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              // margin:
              //     const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              width: double.infinity,
              child: TextField(
                // onChanged: (val) {},
                cursorColor: Colors.white,
                cursorHeight: 28,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  fontSize: 25,
                ),
                decoration: InputDecoration(
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
                onSubmitted: (query) => {
                  // print("the query is: " + query),
                  // _renderShowModal(query)
                  // _search(context)
                },
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.only(left: 5, right: 5),
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
              ),
            ),
          ],
        )
>>>>>>> f6ee7d3cdc703eab2e8aca40dbaaa2343840a904
      )
    );
  }
}
