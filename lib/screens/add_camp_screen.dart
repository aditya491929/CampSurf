import 'package:flutter/material.dart';

import '../widgets/newCamp/image_input.dart';
import '../widgets/newCamp/location_input.dart';

class AddCampScreen extends StatefulWidget {
  static const routeName = '/addCamp';
  @override
  _AddCampScreenState createState() => _AddCampScreenState();
}

class _AddCampScreenState extends State<AddCampScreen> {
  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            SizedBox(
              width: 25,
            ),
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
      ),
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode currentScope = FocusScope.of(context);
          if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        'Add New CampGround 🏕️',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2,
                            ),
                          ),
                        ),
                        // controller: _titleController,
                        textInputAction: TextInputAction.next,
                        cursorHeight: 29,
                        cursorColor: Theme.of(context).accentColor,
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // ImageInput(_selectImage),
                      ImageInput(),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Price',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2,
                            ),
                          ),
                        ),
                        // controller: _titleController,
                        textInputAction: TextInputAction.next,
                        cursorHeight: 29,
                        cursorColor: Theme.of(context).accentColor,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2,
                            ),
                          ),
                        ),
                        // controller: _titleController,
                        textInputAction: TextInputAction.next,
                        cursorHeight: 29,
                        cursorColor: Theme.of(context).accentColor,
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // LocationInput(_selectPlace),
                      LocationInput(),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: showFab,
        child: FloatingActionButton.extended(
          // onPressed: _savePlace,
          onPressed: () {},
          icon: Icon(Icons.add),
          label: Text(
            "Add CampGround",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Theme.of(context).accentColor,
          foregroundColor: Color.fromRGBO(48, 48, 48, 1),
        ),
      ),
    );
  }
}
