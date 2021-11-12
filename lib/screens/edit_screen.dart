import 'package:flutter/material.dart';
import '../widgets/newCamp/image_input.dart';
import '../widgets/newCamp/location_input.dart';

class EditScreen extends StatefulWidget {
  static const routeName = '/editCamp';
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.close,
            size: 30,
          ),
        ),
        centerTitle: true,
        title: Text('Edit Campground'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.save_outlined,
              size: 30,
              color: Theme.of(context).accentColor,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
