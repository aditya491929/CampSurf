import 'package:flutter/material.dart';

class CampDetail extends StatefulWidget {
  static const routeName = '/campDetail';
  @override
  _CampDetailState createState() => _CampDetailState();
}

class _CampDetailState extends State<CampDetail> {

  String content = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).";

  @override
  Widget build(BuildContext context) {
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
              background: SizedBox(
                child: Image.network(
                  'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1170&q=80',
                  fit: BoxFit.cover,
                ),
              ),
              title: Text("Campground Name"),
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
            child: infoContainer("Price", '1000'),
          ),
          SliverToBoxAdapter(
            child: infoContainer("Description", content),
          ),
          SliverToBoxAdapter(
            child: infoContainer("Location", content),
          )
        ],
      ),
    );
  }

  Widget infoContainer(String heading, String data) {
    return new 
    Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            // height: 400,
            color: Colors.grey[600],
            child: Container(
              margin: EdgeInsets.only(left:20.0, top:20.0, right:20.0, bottom:20.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 10.0),
                    child: Text(
                      heading,
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w400,
                        color: Colors.amber,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 5.0),
                    child: Text(
                      data,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
