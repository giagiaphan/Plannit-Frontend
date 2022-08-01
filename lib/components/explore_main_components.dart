/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plannit_frontend/components/explore_item_card_components.dart';
import 'package:plannit_frontend/components/search_explore_delegate.dart';

// import classes
import 'package:plannit_frontend/models/category_specific_data.dart';
import 'package:plannit_frontend/screens/inner_layers/explore_inner_layers/explore_specified_cat.dart';

/// Components for main view of Explore menu
/// ----------------------------------------------------------------------------

// Horizontal menu of all available categories
class CategoryMenu extends StatelessWidget {
  // init all category names
  static const catNames = [
    ["Địa danh", "Ăn uống"],
    ["Chợ", "Giải trí"],
    ["Mua sắm", "Sức khỏe"],
    ["Di chuyển", "Chỗ ở"],
  ];

  // init all category icons' addresses in assets
  static const catIconAddresses = [
    ["attraction_cat_icon.svg", "restaurant_cat_icon.svg"],
    ["grocery_cat_icon.svg", "entertainment_cat_icon.svg"],
    ["shopping_cat_icon.svg", "health_cat_icon.svg"],
    ["transportation_cat_icon.svg", "lodging_cat_icon.svg"]
  ];

  // init all category's boxes' colors
  static const catBoxColors = [
    [
      Color(0xffff757c),
      Color(0xff15bdb1),
    ],
    [
      Color(0xff99e6fc),
      Color(0xff49acff),
    ],
    [
      Color(0xffa259ff),
      Color(0xffffcbc2),
    ],
    [
      Color(0xffffbb33),
      Color(0xffababff),
    ],
    [
      Color(0xfff7f754),
      Color(0xfffac8ff),
    ],
  ];

  // build the horizonal menu of all available categories
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 5,
        bottom: 10,
      ),
      height: 145,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return CatBlock(
            catNames: catNames[index],
            catIconAddresses: catIconAddresses[index],
            catBoxColors: catBoxColors[index],
          );
        },
        itemCount: catNames.length,
      ),
    );
  }
}

// Build 2-box blocks of categories
// for the horizontal category menu
class CatBlock extends StatelessWidget {
  final catNames;
  final catIconAddresses;
  final catBoxColors;

  CatBlock({
    this.catNames,
    this.catIconAddresses,
    this.catBoxColors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5),
      child: Column(
        children: [
          CatBox(
            catBoxColor: catBoxColors[0],
            catIconAddress: catIconAddresses[0],
            catName: catNames[0],
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          CatBox(
            catBoxColor: catBoxColors[1],
            catIconAddress: catIconAddresses[1],
            catName: catNames[1],
          ),
        ],
      ),
    );
  }
}

// One category box for one horizontal menu's block
class CatBox extends StatelessWidget {
  final catBoxColor;
  final catIconAddress;
  final catName;

  CatBox({
    this.catBoxColor,
    this.catIconAddress,
    this.catName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExploreSpecifiedCatWidget(
              query: CategorySpecificData.catMap[catName],
              needAddToPlan: false,
              inSaved: false,
              inPlanEditor: false,
            ),
          ),
        );
      },
      child: Container(
        height: 62.5,
        width: 130,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: catBoxColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/icons/" + catIconAddress,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: EdgeInsets.only(top: 2),
            ),
            Text(
              catName,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ],
        ),
      ),
    );
  }
}

// Horizontal listview of Explore items
// for the feature category
class BusinessHorizontalListView extends StatelessWidget {
  final List exploreList;
  final bool needSmallCard;

  BusinessHorizontalListView({
    this.exploreList,
    @required this.needSmallCard,
  }) : assert(needSmallCard != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: exploreList.length,
        itemBuilder: (context, index) {
          return ExploreItemCard(
            needVoteAndDel: false,
            inSaved: false,
            inPlanEditor: false,
            exploreItem: exploreList[index],
            needAddToPlan: false,
            needSmallCard: needSmallCard,
          );
        },
      ),
    );
  }
}

// Name of featured category & "Xem them" button
// in the horizontal listview of Explore items
class FeaturedCategory extends StatelessWidget {
  final featuredCat;

  FeaturedCategory({this.featuredCat});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Text(
            '${featuredCat}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(bottom: 5, top: 5),
            child: GestureDetector(
              onTap: () {
                print(featuredCat);
                print(CategorySpecificData.catMap[featuredCat]);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExploreSpecifiedCatWidget(
                      query: featuredCat,
                      needAddToPlan: false,
                      inSaved: false,
                      inPlanEditor: false,
                    ),
                  ),
                );

                //SearchExploreDelegate.quer
              },
              child: Text(
                'Xem thêm',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
