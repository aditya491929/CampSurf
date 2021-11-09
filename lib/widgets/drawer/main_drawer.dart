import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Colors.amber,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.black,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomLeft,
            child: Text(
              'Hello User!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Home', Icons.home_outlined, () {
            Navigator.of(context).pushReplacementNamed('/home');
          }),
          Divider(
            color: Colors.grey,
          ),
          buildListTile('Favourites', Icons.favorite_outline_outlined, () {
            Navigator.of(context).pushReplacementNamed('/favouriteCamps');
          }),
          Divider(
            color: Colors.grey,
          ),
          buildListTile('Your Listings', MdiIcons.tent, () {
            Navigator.of(context).pushReplacementNamed('/yourPosts');
          }),
          Divider(
            color: Colors.grey,
          ),
          buildListTile('Logout', Icons.logout_outlined, () {
            // Navigator.of(context).pushReplacementNamed('/');
            FirebaseAuth.instance.signOut();
          }),
          Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
