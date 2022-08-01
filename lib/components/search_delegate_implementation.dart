/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/material.dart';
import 'package:plannit_frontend/screens/inner_layers/explore_inner_layers/explore_specified_cat.dart';

class SearchDelegateImplementation extends StatefulWidget {
  final bool needAddToPlan;
  final chosenExplore;

  SearchDelegateImplementation({
    @required this.needAddToPlan,
    this.chosenExplore,
  }) : assert(needAddToPlan != null);

  _SearchDelegateImplementation createState() =>
      _SearchDelegateImplementation();
}

class _SearchDelegateImplementation
    extends State<SearchDelegateImplementation> {
  final myController = TextEditingController();
  String dropDownValue = "Hoàn Kiếm, Hà Nội";
  final List<String> locations = [
    "Hoàn Kiếm, Hà Nội",
  ];
  final List<String> suggestions = [
    "bánh xèo",
    "bún chả obama",
    "phở thìn",
    "bún chả que tre",
  ];

  //final query;

  @override
  void initState() {
    //query = '';
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
                border: InputBorder.none, hintText: 'Tìm nơi khám phá'),
            autofocus: true,
            onSubmitted: (query) {
              print(query);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ExploreSpecifiedCatWidget(
                    inSaved: false,
                    inPlanEditor: false,
                    query: query,
                    needAddToPlan: widget.needAddToPlan,
                    chosenExplore: widget.chosenExplore,
                  ),
                ),
              );
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: ListView.separated(
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
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 10,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Icon(Icons.location_on),
                    ),
                    DropdownButton<String>(
                      value: dropDownValue,
                      onChanged: (String newValue) {
                        setState(() {
                          dropDownValue = newValue;
                        });
                      },
                      items: locations
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
