/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import classes
import 'package:plannit_frontend/components/collaborator_components.dart';

class FriendList extends StatelessWidget {
  final currInvitees;

  FriendList({this.currInvitees});

  DocumentReference userDoc = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        title: Text("Danh sách bạn bè"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: userDoc.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.data()['friends'].length,
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 40.0),
              itemBuilder: (context, index) {
                return FriendCard(
                  friendId: snapshot.data.data()['friends'][index],
                  currInvitees: currInvitees,
                  inCollaboration: false,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner
          return CircularProgressIndicator();
        },
      ),
    );
  }
}