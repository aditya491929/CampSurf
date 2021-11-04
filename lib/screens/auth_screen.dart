import 'package:flutter/material.dart';

import '../widgets/auth/auth_form.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({ Key? key }) : super(key: key);
  static const routeName = '/';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: AuthForm(false),
      ),
    );
  }
}