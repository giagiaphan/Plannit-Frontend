/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/material.dart';
import 'package:plannit_frontend/screens/inner_layers/explore_inner_layers/explore_specified_cat.dart';

class UserSearchDelegateImplementation extends StatefulWidget {

  _UserSearchDelegateImplementation createState() =>
      _UserSearchDelegateImplementation();
}

class _UserSearchDelegateImplementation
    extends State<UserSearchDelegateImplementation> {
  final myController = TextEditingController();

  final List<String> locations = [
    "Hoàn Kiếm, Hà Nội",
    "Hai Bà Trưng, Hà Nội",
    "Ba Đình, Hà Nội",
    "Hoàng Mai, Hà Nội",
  ];
  final List<String> suggestions = [
    "Khải Ngô",
    "Nghĩa Phạm",
    "Minh Phạm",
    "Hiệp Nguyễn",
  ];

  //final query;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          alignment: Alignment.centerLeft,
          color: Colors.white,
          child: TextField(
            controller: myController,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Tìm bạn'),
            autofocus: true,
            onSubmitted: (query) {
              print(query);

              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ExploreSpecifiedCatWidget(
              //       inSaved: false,
              //       inPlanEditor: false,
              //       query: query,
              //       needAddToPlan: widget.needAddToPlan,
              //       chosenExplore: widget.chosenExplore,
              //     ),
              //   ),
              // );
            },
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              myController.clear();
            },
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestions[index]),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
