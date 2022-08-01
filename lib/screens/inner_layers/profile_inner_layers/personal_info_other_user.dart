/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import library
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import classes
import 'package:plannit_frontend/components/user_personal_info_components.dart';
import 'package:plannit_frontend/models/user_data.dart';

class PersonalInfoOtherUserWidget extends StatefulWidget {
  final userVisiting;

  PersonalInfoOtherUserWidget({@required this.userVisiting});

  _PersonalInfoOtherUserWidgetState createState() =>
      _PersonalInfoOtherUserWidgetState();
}

class _PersonalInfoOtherUserWidgetState
    extends State<PersonalInfoOtherUserWidget> {
  Stream clientUserStream;

  @override
  void initState() {
    clientUserStream = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .snapshots();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: widget.userVisiting == null
          ? Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
                child: Text(
                    "Có vẻ như chúng tôi không tìm được bạn của bạn qua email này ;(",
                  style: TextStyle(fontSize: 18),
                ),
              ),
          )
          : StreamBuilder<DocumentSnapshot>(
              stream: clientUserStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading...");
                }

                // Get reference to current client's user
                UserData clientUser =
                    UserData.fromJson(snapshot.data.data(), snapshot.data.id);

                return ListView(
                  children: [
                    UserAvatar(),
                    UserName(username: widget.userVisiting.username),
                    UserBio(),
                    UserActivity(
                      public_plan_count: widget.userVisiting.public_plan_count,
                      followers: widget.userVisiting.followers,
                      following: widget.userVisiting.following,
                    ),
                    RatingAve(
                        rating_average: widget.userVisiting.rating_average),
                    ReviewCount(review_count: widget.userVisiting.review_count),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          color: Color(0xffffcbc2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.5),
                          ),
                          onPressed: () {
                            // add friend or un-friend
                            List updatedFriendList = clientUser.friends;
                            String visitingUserId = widget.userVisiting.userId;

                            if (updatedFriendList.contains(visitingUserId)) {
                              updatedFriendList.remove(visitingUserId);
                            } else {
                              updatedFriendList.add(visitingUserId);
                            }

                            // Update the user's friend list in Firestore
                            DocumentReference clientUserDoc = FirebaseFirestore
                                .instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser.uid);
                            clientUserDoc
                                .update({'friends': updatedFriendList})
                                .then((value) => print("User Updated"))
                                .catchError((error) =>
                                    print("Failed to update user: $error"));
                          },
                          padding: EdgeInsets.all(10.0),
                          child: clientUser.friends
                                  .contains(widget.userVisiting.userId)
                              ? Text(
                                  "Hít le bạn",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                )
                              : Text(
                                  "Kết bạn",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
    );
  }
}
