import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final users = FirebaseFirestore.instance.collection('users');
    return Drawer(
      child: Column(
        children: [
          FutureBuilder(
            future: users.doc(user!.uid).get(),
            builder: (BuildContext ctx, snapShot) {
              if (snapShot.connectionState == ConnectionState.done){
                DocumentSnapshot<Object?> data = snapShot.data! as DocumentSnapshot;
                return Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.black,
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Hello, ${data["username"]}!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                );
              }
              return Container(
                height: 150,
                width: double.infinity,
                color: Colors.black,
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Hello, ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
            },
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
