/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

//import library
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:plannit_frontend/components/network_endpoints.dart';

//import classes
import 'package:plannit_frontend/components/search_bar.dart';
import 'package:plannit_frontend/components/search_delegate_implementation.dart';
import 'package:plannit_frontend/components/search_explore_delegate.dart';
import 'package:plannit_frontend/models/category_specific_data.dart';
import 'package:plannit_frontend/models/explore_data.dart';
import 'package:plannit_frontend/components/explore_item_card_components.dart';

class ExploreSpecifiedCatWidget extends StatefulWidget {
  final int currCatIndex;
  final currCat;
  final query;
  final chosenExplore;
  final bool needAddToPlan;
  final bool inSaved;
  final bool inPlanEditor;
  final bool needVoteAndDel = false;

  ExploreSpecifiedCatWidget({
    this.currCatIndex,
    this.currCat,
    this.chosenExplore,
    @required this.inSaved,
    @required this.inPlanEditor,
    @required this.query,
    @required this.needAddToPlan,
  })  : assert(needAddToPlan != null),
        assert(query != null),
        assert(inSaved != null),
        assert(inPlanEditor != null);

  @override
  _ExploreSpecifiedCatWidgetState createState() =>
      _ExploreSpecifiedCatWidgetState();
}

class _ExploreSpecifiedCatWidgetState extends State<ExploreSpecifiedCatWidget> {
  // Chosen Explore items for certain category in a Plan
  //Map<String, dynamic> chosenItems = new Map();

  // Loaded Explore items from backend
  List<ExploreData> listExploreItems;

  // Init page number
  int pageNumber;

  // Init scrolling controller
  var scrollController = ScrollController();

  Future<void> getExploreItems() async {
    var exploreListFuture = await fetchExploreJson(widget.query, pageNumber);
    print('getExploreItems');
    setState(() {
      listExploreItems.addAll(exploreListFuture);
    });
  }

  @override
  void initState() {
    super.initState();

    // init explore list & first page
    listExploreItems = List();
    pageNumber = 0;

    getExploreItems();

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
            pageNumber++;
          });
          getExploreItems(); // Load next explore items
        }
      }
    });
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.query),
          automaticallyImplyLeading: false,
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
                    builder: (context) => SearchDelegateImplementation(
                      needAddToPlan: widget.needAddToPlan,
                      chosenExplore: widget.chosenExplore,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: CustomScrollView(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          slivers: [
            // SliverAppBar(
            //   floating: true,
            //   automaticallyImplyLeading: false,
            //   flexibleSpace: FlexibleSpaceBar(
            //     background: Stack(
            //       children: [
            //         // Decoration background for expanded part
            //         Container(
            //           width: MediaQuery
            //               .of(context)
            //               .size
            //               .width,
            //           height: MediaQuery
            //               .of(context)
            //               .size
            //               .height,
            //           color: Color(0xfffff5f5),
            //         ),
            //
            //         // Search bar
            //         Column(
            //           children: [
            //             ExploreInnerSearchBar(
            //               needAddToPlan: widget.needAddToPlan,
            //               inPlanEditor: widget.inPlanEditor,
            //               inSaved: widget.inSaved,
            //               chosenItems: chosenItems,
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            //   expandedHeight: 104,
            // ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: ExploreItemCard(
                      needVoteAndDel: widget.needVoteAndDel,
                      inSaved: widget.inSaved,
                      inPlanEditor: widget.inPlanEditor,
                      exploreItem: listExploreItems[index],
                      currCatIndex: widget.currCatIndex,
                      chosenExplore: widget.chosenExplore,
                      needAddToPlan: widget.needAddToPlan,
                      needSmallCard: false,
                    ),
                  );
                },
                childCount: listExploreItems.length,
              ),
            )
          ],
        ),
      ),

      // this is to prevent user from swiping to exit the cat specified screen
      onWillPop: () async => !(Navigator.of(context).userGestureInProgress),
    );
  }
}
