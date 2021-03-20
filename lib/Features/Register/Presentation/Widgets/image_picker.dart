import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedimage) imagepickfn;

  UserImagePicker(this.imagepickfn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  final picker = ImagePicker();
  File _image;

  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Oops..!"),
              content: new Text("Please select image !"),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  void _imagepick() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(
      () {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          _showMaterialDialog();
        }
      },
    );
    widget.imagepickfn(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Upload Profile Pic... !'),
        SizedBox(height: 15),
        CircleAvatar(
          backgroundImage: _image != null ? FileImage(_image) : null,
          radius: 40,
        ),
        TextButton.icon(
          onPressed: _imagepick,
          icon: Icon(Icons.photo_camera_outlined),
          label: Text('add!'),
        )
      ],
    );
  }
}
