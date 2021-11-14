import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './your_listings.dart';

class EditScreen extends StatefulWidget {
  static const routeName = '/editCamp';
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  var campId;

  void _editCamp() async {
    try {
      if (_titleController.text.isEmpty ||
          _priceController.text.isEmpty ||
          _descriptionController.text.isEmpty) {
        return;
      }

      await FirebaseFirestore.instance
          .collection('camp-details')
          .doc(campId)
          .update({
        'title': _titleController.text,
        'price': _priceController.text,
        'description': _descriptionController.text,
      });
      print('Done');
      final snackBar = SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          'Camp Edited Successfully! 🎉',
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pushReplacementNamed(YourListings.routeName);
    } catch (error) {
      print(error);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text(
                'Okay',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    campId = routeArgs['cid'];
    final _initialTitle = routeArgs['title'];
    final _initialPrice = routeArgs['price'];
    final _initialDescription = routeArgs['description'];

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
            onPressed: _editCamp,
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
                      controller: _titleController..text = _initialTitle!,
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
                      controller: _priceController..text = _initialPrice!,
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
                      controller: _descriptionController
                        ..text = _initialDescription!,
                      textInputAction: TextInputAction.done,
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
