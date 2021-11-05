import 'package:flutter/material.dart';
import 'package:campsurf/screens/tabs_screen.dart';


class CampDetails extends StatefulWidget {
  static const routeName = '/camp';
  // final int initialIndex;
  // final ValueChanged<int> navCallback;
  // CampDetails({@required this.navCallback, this.initialIndex: 0});

  @override
  _CampDetailsState createState() => _CampDetailsState();
}

class _CampDetailsState extends State<CampDetails> {
  // int _selected;

  // @override
  // void initState() {
  //   super.initState();
  //   _selected = widget.initialIndex;
  //   notifyCallback();
  // }

  @override
  Widget build(BuildContext context) {

    String content = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).";

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
              width: 1,
            ),
            RichText(
              text: TextSpan(
                text: 'Campsite Name',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(CampDetails.routeName);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Container(
            // child: new Image.asset('assets/images/campsite.svg'),
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Image.network('https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1170&q=80'),
                // Text('data'),
                Container(
                  child: Column(
                    children: <Widget>[
                      infoContainer("Price", '1000'),
                      infoContainer("Description", content),
                      infoContainer("Location", content),
                    ],
                  ),
                ),
              ],
            )
          )
        )
      )
    );
  }

  Widget infoContainer(String heading, String data) {
    return new Container(
      margin: EdgeInsets.only(left:30.0, top:20.0, right:30.0, bottom:20.0),
      child: Column(
        children: [
          Text(
            heading,
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w400,
              color: Colors.amber,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            data,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      )
    );
  }
  // onButtonTap(int index) {
  //   setState(() {
  //     _selected = index;
  //   });
  //   notifyCallback();
  // }
  // notifyCallback() {
  //   widget.navCallback(_selected);
  // }

  // link: https://kodestat.gitbook.io/flutter/flutter-changing-icon-color-onfocus
}
