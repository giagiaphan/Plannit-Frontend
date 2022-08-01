/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import library
import 'package:flutter/material.dart';

// import classes
import 'package:plannit_frontend/components/user_personal_info_components.dart';

class PersonalInfoWidget extends StatefulWidget {
  final user;

  PersonalInfoWidget({this.user});

  _PersonalInfoWidgetState createState() => _PersonalInfoWidgetState();
}

class _PersonalInfoWidgetState extends State<PersonalInfoWidget> {


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
        title: Text("Thông tin người dùng"),
        centerTitle: true,
      ),
      //extendBodyBehindAppBar: true,
      body: ListView(
        children: [
          UserAvatar(),  // add user url here
          UserName(username: widget.user.username),
          UserBio(),
          UserActivity(
            public_plan_count: widget.user.public_plan_count,
            followers: widget.user.followers,
            following: widget.user.following,
          ),
          RatingAve(rating_average: widget.user.rating_average),
          ReviewCount(review_count: widget.user.review_count),
          //FollowButton(),
          // ConstrainedBox(
          //   constraints: BoxConstraints(
          //     minHeight: 0,
          //     maxWidth: 400,
          //     maxHeight: 1000,
          //     minWidth: 0,
          //   ),
          //   child: UserTab(),
        ],
      ),
    );
  }
}