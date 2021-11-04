import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  var _storedImage = null;
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
          child: _storedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _storedImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
              : Text(
                  'Add an image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: TextButton.icon(
            // onPressed: _takePicture,
            onPressed: () {},
            icon: Icon(
              Icons.camera_alt_outlined,
              color: Colors.amber,
            ),
            label: Text(
              'Take Picture',
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
