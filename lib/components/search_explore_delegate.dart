/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/material.dart';
import 'package:plannit_frontend/screens/inner_layers/explore_inner_layers/explore_specified_cat.dart';

class SearchExploreDelegate extends SearchDelegate {
  final List<String> suggestions = [
    "trà sữa",
    "bánh xèo",
    "đi chơi",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //close(context, query);

    return ExploreSpecifiedCatWidget(
      inSaved: false,
      inPlanEditor: false,
      query: query,
      needAddToPlan: false,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
        );
      },
    );
  }
}
