/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


// import classes
import 'package:plannit_frontend/components/collaborator_components.dart';


class AddCollaborator extends StatefulWidget {
  final currInvitees;

  AddCollaborator({this.currInvitees});

  @override
  _AddCollaboratorState createState() => _AddCollaboratorState();
}

class _AddCollaboratorState extends State<AddCollaborator> {
  List invitees;

  @override
  void initState() {
    invitees = widget.currInvitees;
    super.initState();
  }
  final uid = FirebaseAuth.instance.currentUser.uid;

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
            Navigator.pop(context, widget.currInvitees);
          },
        ),
        automaticallyImplyLeading: false,
        title: Text("Thêm bạn vào kế hoạch"),
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
                  inCollaboration: true,
                  friendId: snapshot.data.data()['friends'][index],
                  currInvitees: widget.currInvitees,
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