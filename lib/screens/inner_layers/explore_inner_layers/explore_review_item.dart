/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';

// import classes
import 'package:plannit_frontend/models/review_data.dart';
import 'package:plannit_frontend/screens/inner_layers/explore_inner_layers/take_pic_screen.dart';

class ExploreReviewWidget extends StatefulWidget {
  final businessId;
  final businessName;
  final rating;

  ExploreReviewWidget({
    @required this.businessId,
    this.businessName,
    this.rating,
  }) : assert(businessId != null);

  @override
  _ExploreReviewWidgetState createState() => _ExploreReviewWidgetState();
}

class _ExploreReviewWidgetState extends State<ExploreReviewWidget> {
  List<File> _images = [];
  final myController = TextEditingController();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final uid = FirebaseAuth.instance.currentUser.uid;

  CollectionReference reviews =
  FirebaseFirestore.instance.collection('reviews');

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  void displayDialog(context, title, text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  // Future<List<String>> getURLs(List<File> images) async {
  //   _images.forEach((image) async {
  //     // regex to get picture's name
  //     String file = image.toString();
  //     String fileName = file.substring(
  //         file.lastIndexOf('/'), file.length);
  //
  //     var uploadTask = storage
  //         .ref()
  //         .child("${widget.businessId}")
  //         .child("/${fileName}")
  //         .putFile(image);
  //
  //     print("Before location");
  //     var location = await (await uploadTask.onComplete)
  //         .ref
  //         .getDownloadURL();
  //     print("DEBUG in Đăng đánh giá:" + location);
  //     setState(() {
  //       urls.add(location);
  //     });
  //   });
  //
  //   return urls;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Đánh giá chúng tôi"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.businessName,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),

                //Rating from prior layer
                RatingBar.builder(
                  initialRating: widget.rating,
                  // whatever number from last layer, put it here
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.red,
                        );
                      case 1:
                        return Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.redAccent,
                        );
                      case 2:
                        return Icon(
                          Icons.sentiment_neutral,
                          color: Colors.amber,
                        );
                      case 3:
                        return Icon(
                          Icons.sentiment_satisfied,
                          color: Colors.lightGreen,
                        );
                      case 4:
                        return Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        );
                    }
                    return null;
                  },
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),

                //Text review (textbox?)
                TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Chỗ này được đấy',
                  ),
                ),
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
              ],
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.all(15),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      List<File> pictures = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TakePictureWidget(),
                        ),
                      );
                      print("DEBUG in ReviewItem: " + pictures.toString());

                      // Add pictures to temp local buffer
                      // waiting for upload to Firebase Storage
                      if (pictures != null) {
                        setState(() {
                          _images.addAll(pictures);
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera_enhance),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                        ),
                        Text(
                          "Thêm ảnh",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // add validation for empty string review
                      if (myController.text.length > 0) {
                        reviews
                            .add(ReviewData.toJson(
                          widget.businessId,
                          myController.text,
                          widget.rating.toInt(),
                          uid,
                          [], // this should be the picture urls
                        ))
                            .then((value) async {
                          _images.forEach((image) async {
                            // regex to get picture's name
                            String file = image.toString();
                            String fileName = file.substring(
                                file.lastIndexOf('/'), file.length);

                            var uploadTask = storage
                                .ref()
                                .child("${widget.businessId}")
                                .child("/${fileName}")
                                .putFile(image);

                            var location = await (await uploadTask.onComplete)
                                .ref
                                .getDownloadURL();

                            // update the review with urls
                            reviews.doc(value.id).update({'pictures': FieldValue.arrayUnion([location])});
                          });

                          Navigator.pop(context);
                        }).catchError((error) =>
                            print("Failed to add review: $error"));
                      } else {
                        displayDialog(
                          context,
                          "Đánh giá",
                          "Bạn nhớ viết đánh giá nữa nhé!",
                        );
                      }
                    },
                    child: Text(
                      "Đăng đánh giá",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}