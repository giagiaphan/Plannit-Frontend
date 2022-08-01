/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import library
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class TakeAvatarWidget extends StatefulWidget {
  _TakeAvatarWidgetState createState() => _TakeAvatarWidgetState();
}

class _TakeAvatarWidgetState extends State<TakeAvatarWidget> {
  File _image;

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    // Let user select photo from gallery
    if (gallery) {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,
      );
    }
    // Otherwise open camera to get new photo
    else {
      pickedFile = await picker.getImage(
        source: ImageSource.camera,
      );
    }

    setState(() {
      if (pickedFile != null) {
        //_images.add(File(pickedFile.path));
        _image = File(pickedFile.path); // Use if you only need a single picture
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm ảnh"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                if (_image != null) {
                  Navigator.pop(context, _image);
                }
              },
              child: Center(
                child: Text(
                  "Tiếp tục",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Show pictures here
          SizedBox(
            height: 450,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 550,
                width: 300,
                child: Stack(
                  children: [
                    Image.file(
                      _image,
                      fit: BoxFit.fill,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                        //color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _image = null;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RawMaterialButton(
                  fillColor: Theme.of(context).accentColor,
                  child: Icon(
                    Icons.photo_filter,
                    color: Colors.white,
                  ),
                  elevation: 8,
                  onPressed: () {
                    getImage(true);
                  },
                  padding: EdgeInsets.all(15),
                  shape: CircleBorder(),
                ),
                RawMaterialButton(
                  fillColor: Theme.of(context).accentColor,
                  child: Icon(
                    Icons.camera_enhance,
                    color: Colors.white,
                  ),
                  elevation: 8,
                  onPressed: () {
                    getImage(false);
                  },
                  padding: EdgeInsets.all(15),
                  shape: CircleBorder(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
