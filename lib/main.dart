import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/auth_screen.dart';
import './screens/tabs_screen.dart';
import './screens/add_camp_screen.dart';
import './screens/favourites_screen.dart';
import './screens/your_listings.dart';
import './providers/places.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Places(),
      child: MaterialApp(
        title: 'CampSurf',
        theme: ThemeData.dark().copyWith(
          accentColor: Colors.amber,
          primaryColor: Colors.black,
          textTheme: TextTheme(
            button: TextStyle(color: Colors.white),
          ),
        ),
        // home: AuthScreen(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          AuthScreen.routeName : (ctx) => AuthScreen(),
          TabsScreen.routeName : (ctx) => TabsScreen(),
          AddCampScreen.routeName : (ctx) => AddCampScreen(),
          FavouritesScreen.routeName : (ctx) => FavouritesScreen(),
          YourListings.routeName : (ctx) => YourListings(),
        }
      ),
    );
  }
}

