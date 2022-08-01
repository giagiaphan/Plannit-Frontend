/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import classes
import 'package:plannit_frontend/components/collaborator_components.dart';
import 'package:plannit_frontend/components/network_endpoints.dart';
import 'package:plannit_frontend/models/user_data.dart';

class SearchPeopleView extends StatefulWidget {
  final query;

  SearchPeopleView({@required this.query}) : assert(query != null);

  _SearchPeopleViewState createState() => _SearchPeopleViewState();
}

class _SearchPeopleViewState extends State<SearchPeopleView> {
  List<UserData> _people;

  // Controlling which page is at
  int pageNum;

  // Init scrolling controller
  var scrollController = ScrollController();

  Future<void> getPeople() async {
    var peopleListFuture = await fetchUsersJson(widget.query, pageNum);
    print('getPeople');
    setState(() {
      _people.addAll(peopleListFuture);
    });
  }

  @override
  void initState() {
    super.initState();

    // init people list & first page
    _people = List();
    pageNum = 0;

    getPeople();

    // init scroll controller
    // to detect end of page
    // and load more Explore items
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          print("ListView scroll at top");
        } else {
          print("ListView scroll at bottom");
          setState(() {
            pageNum++;
          });
          getPeople(); // Load next explore items
        }
      }
    });
  }

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
        title: Text(widget.query),
        centerTitle: true,
      ),
      body: CustomScrollView(
        controller: scrollController,
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverList(delegate: SliverChildBuilderDelegate((context, index) {
            UserData person = _people[index];

            return PeopleCard(
              person: person,
            );
          })),
        ],
      ),
    );
  }
}
