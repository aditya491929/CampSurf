import 'package:campsurf/screens/add_camp_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../widgets/drawer/main_drawer.dart';
import './camp_listings.dart';
import './map_screen.dart';
import './search_modal.dart';


class TabsScreen extends StatefulWidget {
  static const routeName = '/home';
  
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
    double? topPadding;

  _renderShowModal(){
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10),),
      ),
      context: context,
      builder: (BuildContext context) {

        return Container(
          height: MediaQuery.of(context).size.height - topPadding!,
          child: Column(
            children: <Widget>[
              // Container(
              //   height: 5,
              //   width: 55,
              //   margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              //   decoration: BoxDecoration(
              //     color: Theme.of(context).accentColor,
              //     borderRadius: BorderRadius.circular(10)
              //   ),
              // ),
              Expanded(
                child: SizedBox(
                  child: SearchModal(),
                ),
              ),
            ],
          )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    topPadding = MediaQuery.of(context).padding.top;

    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
          centerTitle: true,
          elevation: 4,
          bottom: TabBar(
            indicatorColor: Theme.of(context).accentColor,
            tabs: [
              Tab(
                icon: new Icon(MdiIcons.campfire),
                text: 'Campsites',
              ),
              Tab(
                icon: Icon(Icons.map_outlined),
                text: 'Maps',
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search_rounded,
                size: 30,
              ),
              onPressed: () {
                // Navigator.of(context).pushNamed(AddCampScreen.routeName);
                _renderShowModal();
              },
            ),
          ],
        ),
        drawer: MainDrawer(),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: [CampListings(), MapScreen()],
        ),
        floatingActionButton: Visibility(
          visible: showFab,
          child: FloatingActionButton(
            elevation: 2,
            child: Icon(
              Icons.add,
              size: 30,
              color: Color.fromRGBO(48, 48, 48, 1),
            ),
            backgroundColor: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.of(context).pushNamed(AddCampScreen.routeName);
            },
          ),
        ),
      ),
    );
  }
}
