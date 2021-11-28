import 'dart:io';
import 'dart:ui';
import 'package:campsurf/helpers/location_helper.dart';
import 'package:campsurf/models/place.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/newCamp/image_input.dart';
import '../widgets/newCamp/location_input.dart';

class AddCampScreen extends StatefulWidget {
  static const routeName = '/addCamp';
  @override
  _AddCampScreenState createState() => _AddCampScreenState();
}

class _AddCampScreenState extends State<AddCampScreen> {
  var _isLoading = false;
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _saveCamp() async {
    try {
      if (_titleController.text.isEmpty ||
          _priceController.text.isEmpty ||
          _descriptionController.text.isEmpty ||
          _pickedImage == null ||
          _pickedLocation == null) {
        return;
      }
      setState(() {
        _isLoading = true;
      });
      final ref = FirebaseStorage.instance
          .ref()
          .child('Camp_image')
          .child(_titleController.text + '.jpg');
      await ref.putFile(_pickedImage!);
      print('Step1');
      final url = await ref.getDownloadURL();
      print('Step2 $url');

      final address = await LocationHelper.getCampAddress(
          _pickedLocation!.latitude, _pickedLocation!.longitude);

      final updatedLocation = PlaceLocation(
        latitude: _pickedLocation!.latitude,
        longitude: _pickedLocation!.longitude,
        address: address,
      );

      final newCamp = Place(
        id: DateTime.now().toString(),
        title: _titleController.text,
        price: _priceController.text,
        description: _descriptionController.text,
        location: updatedLocation,
        image: url,
      );

      print('Step3');

      final user = FirebaseAuth.instance.currentUser;

      List<String> splitList = newCamp.title!.split(' ');
      List<String> indexList = [];

      for (int i = 0; i < splitList.length; i++) {
        for (int j = 0; j < splitList[i].length + i; j++) {
          indexList.add(splitList[i].substring(0, j).toLowerCase());
        }
      }

      await FirebaseFirestore.instance.collection('camp-details').doc().set({
        'uid': user!.uid,
        'cid': newCamp.id,
        'title': newCamp.title,
        'price': newCamp.price,
        'description': newCamp.description,
        'image_url': newCamp.image,
        'loc_lat': newCamp.location!.latitude,
        'loc_lng': newCamp.location!.longitude,
        'address': newCamp.location!.address,
        'searchIndex': indexList,
      });
      print('Done');
      final snackBar = SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          'Camp Listed Successfully! 🎉',
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop();
    } catch (error) {
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
        child: Stack(
          children: [
            Column(
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
                            '🏕️ Add New CampGround',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Title',
                              labelStyle: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
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
                            controller: _titleController,
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
                          ImageInput(_selectImage),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Price',
                              labelStyle: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
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
                            controller: _priceController,
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
                              labelStyle: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
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
                            controller: _descriptionController,
                            textInputAction: TextInputAction.next,
                            cursorHeight: 29,
                            cursorColor: Theme.of(context).accentColor,
                            style: TextStyle(
                              fontSize: 23,
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          LocationInput(_selectPlace),
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
            if (_isLoading)
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Theme.of(context).accentColor,
                      ),
                      Text(
                        'Adding Campsite 🏕',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
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
          onPressed: _saveCamp,
          icon: Icon(Icons.add),
          label: Text(
            "Add CampGround",
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Theme.of(context).accentColor,
          foregroundColor: Color.fromRGBO(48, 48, 48, 1),
        ),
      ),
    );
  }
}
