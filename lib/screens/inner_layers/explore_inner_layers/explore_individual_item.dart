/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/material.dart';

// import classes
import 'package:plannit_frontend/components/explore_individual_item_components.dart';

class IndividualExploreItem extends StatefulWidget {
  final int currCatIndex;
  final chosenExplore;
  final exploreItem;
  final bool needAddToPlan;

  IndividualExploreItem({
    this.currCatIndex,
    this.chosenExplore,
    @required this.exploreItem,
    @required this.needAddToPlan,
  })  : assert(exploreItem != null),
        assert(needAddToPlan != null);

  @override
  _IndividualExploreItemState createState() => _IndividualExploreItemState();
}

class _IndividualExploreItemState extends State<IndividualExploreItem> {
  // setting up fonts
  final bigFontSize = 40.0;
  final mediumFontSize = 20.0;
  final smallFontSize = 18.0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Khám phá"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        //backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      //extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomAppBar(
        elevation: 20,
        color: Colors.white,
        child: widget.needAddToPlan
            ? AddToPlanBottomAppBar(
                smallFontSize: smallFontSize,
                currCatIndex: widget.currCatIndex,
                currExploreId: widget.exploreItem.business_id,
                chosenItems: widget.chosenExplore,
                rating: widget.exploreItem.rating,
                reviewCount: widget.exploreItem.review_count,
              )
            : ItemStatBottomAppBar(
                smallFontSize: smallFontSize,
                currCatIndex: widget.currCatIndex,
                currExploreId: widget.exploreItem.business_id,
                chosenOnes: widget.chosenExplore,
                rating: widget.exploreItem.rating,
                review_count: widget.exploreItem.review_count,
              ),
      ),
      body: ListView(
        padding: EdgeInsets.only(
          top: 0,
        ),
        children: [
          BusinessPicWindow(
            busPic: widget.exploreItem.business_pic[0],
          ),
          BusinessGeneralInfo(
            smallFontSize: smallFontSize,
            bigFontSize: bigFontSize,
            business: widget.exploreItem,
          ),
          SectionDivider(),
          ReviewBox(
            widget.exploreItem.business_id,
            widget.exploreItem.name,
          ),
          SectionDivider(),
          ReviewFromCommunity(businessId: widget.exploreItem.business_id),
        ],
      ),
    );
  }
}
