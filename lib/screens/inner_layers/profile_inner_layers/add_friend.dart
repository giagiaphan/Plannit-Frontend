/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:plannit_frontend/components/collaborator_components.dart';

// import classes
import 'package:plannit_frontend/components/user_search_delegate.dart';
import 'package:plannit_frontend/models/user_data.dart';
import 'package:plannit_frontend/screens/inner_layers/profile_inner_layers/personal_info_other_user.dart';

class AddFriendWidget extends StatefulWidget {
  @override
  _AddFriendWidgetState createState() => _AddFriendWidgetState();
}

class _AddFriendWidgetState extends State<AddFriendWidget> {
  List _people = [
    {'name': 'Khai Ngo', 'group': 'Lời mời kết bạn'},
    {'name': 'Khai Ngo', 'group': 'Lời mời kết bạn'},
    {'name': 'Khai Ngo', 'group': 'Lời mời kết bạn'},
    {'name': 'Hiep Nguyen', 'group': 'Gợi ý kết bạn'},
    {'name': 'Hiep Nguyen', 'group': 'Gợi ý kết bạn'},
    {'name': 'Hiep Nguyen', 'group': 'Gợi ý kết bạn'},
    {'name': 'Hiep Nguyen', 'group': 'Gợi ý kết bạn'},
  ];

  final myController = TextEditingController();
  final GlobalKey<FormState> _findFriendKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
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
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserSearchDelegateImplementation()),
              );
            },
          ),
        ],
        automaticallyImplyLeading: false,
        title: Text("Thêm bạn bè"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: GroupedListView(
          elements: _people,
          groupBy: (element) => element['group'],
          // groupComparator: (item1, item2) =>
          //     item1['name'].compareTo(item2['name']),
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: true,
          groupSeparatorBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          },
          itemBuilder: (c, element) {
            return AddFriendCard(
              name: element['name'],
              group: element['group'],
            );
          },
        ),
      ),
    );
  }
}


