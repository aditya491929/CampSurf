import 'package:flutter/material.dart';

class SearchModal extends StatefulWidget {

  final String query;

  SearchModal({required this.query});

  @override
  _SearchModalState createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5),
        // height: MediaQuery.of(context).size.height * 0.65,
        // child: Column(
        //   children: [
        //     Container(
        //       height: 5,
        //       width: 55,
        //       decoration: BoxDecoration(
        //         color: Theme.of(context).accentColor,
        //         borderRadius: BorderRadius.circular(10)
        //       ),
              
        //     ),
        //   ],
        // ),
        
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
                onTap: () {print('query is: ' + widget.query);},
              ),
            ),
          ),
        ),
      )
    );
  }
}
