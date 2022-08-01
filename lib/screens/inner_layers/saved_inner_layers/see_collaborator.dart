/// This code belongs to Plannit LLC.
/// Copyright © 2020 by Plannit LLC. All rights reserved.

// import libraries
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plannit_frontend/components/collaborator_components.dart';

// import classes
import 'package:plannit_frontend/models/user_data.dart';

class SeeCollaborator extends StatefulWidget {
  final currInvitees;

  SeeCollaborator({this.currInvitees});

  @override
  _SeeCollaboratorState createState() => _SeeCollaboratorState();
}

class _SeeCollaboratorState extends State<SeeCollaborator> {
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
        title: Text("Các thành viên của kế hoạch"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.currInvitees.length,
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 40.0),
        itemBuilder: (context, index) {
          return FriendCard(
            inCollaboration: false,
            friendId: widget.currInvitees[index],
          );
        },
      ),
    );
  }
}