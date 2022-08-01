/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import classes
import 'package:plannit_frontend/models/user_data.dart';
import 'package:plannit_frontend/screens/inner_layers/profile_inner_layers/personal_info_other_user.dart';

/// Components for adding collaborators
/// ----------------------------------------------------------------------------

// Divider for different groups
class GroupDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          "Top friends",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// One card for one friend
class FriendCard extends StatefulWidget {
  final friendId;
  var currInvitees;
  final bool inCollaboration;

  FriendCard({
    this.friendId,
    this.currInvitees,
    @required this.inCollaboration,
  })  : assert(inCollaboration != null);

  @override
  _FriendCardState createState() => _FriendCardState();
}

class _FriendCardState extends State<FriendCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.friendId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData friend =
                UserData.fromJson(snapshot.data.data(), widget.friendId);

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalInfoOtherUserWidget(
                      userVisiting: friend
                    ),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    child: SvgPicture.asset("assets/icons/OFFICIAL_LOGO.svg"),
                  ),
                  title: Text(friend.username),
                  trailing: widget.inCollaboration
                      ? IconButton(
                          onPressed: () {
                            // For debugging add friend to the plan object
                            if (widget.currInvitees != null)
                              print("Length of list: " +
                                  widget.currInvitees.length.toString());

                            if (widget.currInvitees.contains(widget.friendId))
                              setState(() {
                                widget.currInvitees.remove(friend.userId);
                              });
                            else
                              setState(() {
                                widget.currInvitees.add(friend.userId);
                              });
                          },
                          icon: widget.currInvitees.contains(friend.userId)
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : Icon(Icons.check_circle_outline))
                      : Icon(
                          Icons.info,
                          color: Colors.deepPurple,
                        ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner
          return CircularProgressIndicator();
        });
  }
}

class PeopleCard extends StatefulWidget {
  final UserData person;

  PeopleCard({this.person});

  _PeopleCardState createState() => _PeopleCardState();
}

class _PeopleCardState extends State<PeopleCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // show detailed view of user
      },
      child: Card(
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            child: SvgPicture.asset("assets/icons/OFFICIAL_LOGO.svg"),
          ),
          title: Text(widget.person.username),
          // trailing: TextButton(
          //   onPressed: () {
          //     // send add friend invite
          //   },
          //   child: Text("Kết bạn"),
          // ),
        ),
      ),
    );
  }
}

class AddFriendCard extends StatefulWidget {
  final name;
  final group;

  AddFriendCard({this.name, this.group});

  @override
  _AddFriendCardState createState() => _AddFriendCardState();
}

class _AddFriendCardState extends State<AddFriendCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            child: SvgPicture.asset("assets/icons/OFFICIAL_LOGO.svg"),
          ),
          title: Text(widget.name),
          // trailing: widget.group == 'Lời mời kết bạn'
          //     ? Container(
          //   width: 100,
          //   child: Row(
          //     children: [
          //       IconButton(
          //         onPressed: () {},
          //         icon: Icon(
          //           Icons.check_circle,
          //           color: Colors.green,
          //         ),
          //       ),
          //       IconButton(
          //         onPressed: () {},
          //         icon: Icon(
          //           Icons.clear_rounded,
          //           color: Colors.red,
          //         ),
          //       ),
          //     ],
          //   ),
          // )
          //     : TextButton(
          //   onPressed: () {},
          //   child: Text("Kết bạn"),
          ),
        ),
      // ),
    );
  }
}