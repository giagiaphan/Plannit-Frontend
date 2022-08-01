/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

//import library
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:plannit_frontend/screens/inner_layers/profile_inner_layers/take_avatar_screen.dart';

/// Components for Personal Info view for each user of Plannit
/// ----------------------------------------------------------------------------

// Show username of user
class UserName extends StatelessWidget {
  final String username;

  UserName({this.username});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          username,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}

class UserBio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(bottom: 40),
        child: Text(
          'Live to Dream',
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class UserActivity extends StatelessWidget {
  final public_plan_count;
  final followers;
  final following;

  UserActivity({
    this.public_plan_count,
    this.followers,
    this.following,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                //width: 100,
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  'Public plans',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 20,
                  ),
                ),
              ),
              Text(
                public_plan_count.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                'Followers',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 20,
                ),
              ),
            ),
            Text(
              followers.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                'Followings',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 20,
                ),
              ),
            ),
            Text(
              following.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ]),
        ],
      ),
    );
  }
}

class RatingAve extends StatelessWidget {
  final rating_average;

  RatingAve({this.rating_average});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 200,
            child: Text(
              'Rating Average',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[500],
              ),
            ),
          ),
          Text(
            rating_average.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewCount extends StatelessWidget {
  final int review_count;

  ReviewCount({this.review_count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 200,
            child: Text(
              'Review count',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[500],
              ),
            ),
          ),
          Text(
            review_count.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class FollowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // add this user's id to my friend list
        // related to network
      },
      child: Center(
        child: Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: Card(
            color: Color(0xffFF757C),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 0,
                maxWidth: 200,
                maxHeight: 50,
                minWidth: 0,
              ),
              child: Center(
                child: Text(
                  'Follow',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            SizedBox(
              height: 50,
              width: 100,
              child: Tab(
                icon: SizedBox(
                  height: 30,
                  child: SvgPicture.asset("assets/icons/post.svg"),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 100,
              child: Tab(
                icon: SizedBox(
                  height: 30,
                  child: SvgPicture.asset("assets/icons/review_icon.svg"),
                ),
              ),
            ),
          ],
          indicatorColor: Color(0xffFF757C),
        ),
        body: TabBarView(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: UserPics(),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: UserComments(),
            ),
          ],
        ),
      ),
    );
  }
}

class UserComments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: new NeverScrollableScrollPhysics(),
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Card(
              color: Color(0xffFFCBC2),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 0,
                  maxWidth: 400,
                  maxHeight: 80,
                  minWidth: 0,
                ),
                child: Center(
                  child: Text(
                    'Very good 3 stars',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Card(
              color: Color(0xffFFCBC2),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 0,
                  maxWidth: 400,
                  maxHeight: 80,
                  minWidth: 0,
                ),
                child: Center(
                  child: Text(
                    'Terrible please help',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class UserPics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        crossAxisCount: 3,
        physics: new NeverScrollableScrollPhysics(),
        children: [
          Container(
            child: Image.asset(
              "assets/images/ho_guom.png",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Image.asset(
              "assets/images/pho.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Image.asset(
              "assets/images/paris_eiffel.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Image.asset(
              "assets/images/my_wedding_plan.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class UserAvatar extends StatefulWidget {
  final url;

  UserAvatar({this.url});

  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: widget.url == null
                      ? NetworkImage(
                          'https://googleflutter.com/sample_image.jpg')
                      : NetworkImage(widget.url),
                  fit: BoxFit.fill),
            ),
          ),
          GestureDetector(
            onTap: () async {
              // replace avatar: upload new or take new
              File _image = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TakeAvatarWidget()),
              );

              // post to gg storage
              // then update user info with new avatar address
              // delete the old one as well
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_enhance),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  Container(
                    child: Text("Thay avatar"),
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

class PersonalTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Card(
                    color: Color(0xffFFCBC2),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 30,
                        maxWidth: 180,
                        maxHeight: 40,
                        minWidth: 90,
                      ),
                      child: Center(
                        child: Container(
                            width: 25,
                            height: 25,
                            child: SvgPicture.asset("assets/icons/post.svg")),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Card(
                    color: Color(0xffFFCBC2),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 30,
                        maxWidth: 180,
                        maxHeight: 40,
                      ),
                      child: Center(
                        child: Container(
                            width: 25,
                            height: 25,
                            child: SvgPicture.asset(
                                "assets/icons/review_icon.svg")),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
