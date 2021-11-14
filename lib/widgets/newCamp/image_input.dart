import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function(File pickedImage) onSelectImage;
  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _pickedImage = File('');

  Future<void> _chooseCampPhoto() async {
    final picker = ImagePicker();
    var pickedImageFile;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: Text(
            'Campsite Photo',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 25,
            ),
          ),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                pickedImageFile = await picker.pickImage(
                  source: ImageSource.camera,
                );
                setState(() {
                  _pickedImage = File(pickedImageFile.path);
                  Navigator.of(context).pop();
                });
                widget.onSelectImage(File(pickedImageFile.path));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Theme.of(context).accentColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Camera',
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                pickedImageFile =
                    await picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  _pickedImage = File(pickedImageFile.path);
                });
                widget.onSelectImage(File(pickedImageFile.path));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.photo_library_outlined,
                    color: Theme.of(context).accentColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Gallery',
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 180,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: _pickedImage.path.isEmpty
              ? Text(
                  'Add an image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _pickedImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: _chooseCampPhoto,
            icon: Icon(
              Icons.camera_alt_outlined,
              color: Colors.amber,
            ),
            label: Text(
              'Add Photo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
