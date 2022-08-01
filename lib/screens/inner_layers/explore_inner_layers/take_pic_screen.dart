/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import library
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class TakePictureWidget extends StatefulWidget {
  _TakePictureWidgetState createState() => _TakePictureWidgetState();
}

class _TakePictureWidgetState extends State<TakePictureWidget> {
  List<File> _images = [];
  File _image; // Used only if you need a single picture

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
        _images.add(File(pickedFile.path));
        //_image = File(pickedFile.path); // Use if you only need a single picture
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
                if (_images.length > 0) {
                  Navigator.pop(context, _images);
                }
              },
              child: Center(
                child: Text(
                  "Tiếp tục (${_images.length})",
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 550,
                    width: 300,
                    child: Stack(
                      children: [
                        Image.file(
                          _images[index],
                          fit: BoxFit.fill,
                        ),
                        // Container(
                        //   height: 550,
                        //   width: 300,
                        //   decoration: BoxDecoration(
                        //     gradient: LinearGradient(
                        //       begin: Alignment.topCenter,
                        //       end: Alignment.bottomCenter,
                        //       colors: [
                        //         const Color(0x00000000),
                        //         const Color(0x00000000),
                        //         const Color(0x00000000),
                        //         const Color(0xCC000000),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_forever,
                            //color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _images.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
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
