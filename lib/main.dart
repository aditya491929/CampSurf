import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './screens/auth_screen.dart';
import './screens/tabs_screen.dart';
import './screens/add_camp_screen.dart';
import './screens/your_listings.dart';
import './screens/edit_screen.dart';
import './screens/camp_detail_screen.dart';
import './helpers/custom_transition.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CampSurf',
        theme: ThemeData.dark().copyWith(
          accentColor: Colors.amber,
          primaryColor: Colors.black,
          textTheme: TextTheme(
            button: TextStyle(color: Colors.white),
          ),
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CustomPageTransitionBuilder(),
          }),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.active) {
              if (userSnapshot.hasData) {
                return TabsScreen();
              }
            }
            return AuthScreen();
          },
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          TabsScreen.routeName: (ctx) => TabsScreen(),
          AddCampScreen.routeName: (ctx) => AddCampScreen(),
          YourListings.routeName: (ctx) => YourListings(),
          EditScreen.routeName: (ctx) => EditScreen(),
          CampDetail.routeName: (ctx) => CampDetail(),
        });
  }
}
