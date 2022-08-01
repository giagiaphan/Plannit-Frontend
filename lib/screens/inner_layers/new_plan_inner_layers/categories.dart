/// This code belongs to Plannit LLC.
/// Copyright © 2020 by Plannit LLC. All rights reserved.


// import libraries
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import classes
import 'package:plannit_frontend/models/category_specific_data.dart';




class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Các thể loại"),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: GridView.builder(
        padding: EdgeInsets.only(top: 130, left: 10, right: 10),
        itemCount: 9,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return CatBoxBuilder(catIndex: index);
        },
      ),
    );
  }
}

class CatBoxBuilder extends StatelessWidget {
  List<String> catPic = [
    "create_cat_icon.svg",
    "attraction_cat_icon.svg",
    "restaurant_cat_icon.svg",
    "grocery_cat_icon.svg",
    "entertainment_cat_icon.svg",
    "shopping_cat_icon.svg",
    "health_cat_icon.svg",
    "transportation_cat_icon.svg",
    "lodging_cat_icon.svg",
  ];

  List<String> catName = [
    "Ngày đi",
    "Địa danh",
    "Ăn uống",
    "Chợ",
    "Giải trí",
    "Shopping",
    "Sức khỏe",
    "Di chuyển",
    "Chỗ ở",
  ];

  List<Color> borderColor = [
    Colors.black,
    Color(0xffff757c),
    Color(0xff15bdb1),
    Color(0xff99e6fc),
    Color(0xff49acff),
    Color(0xffa259ff),
    Color(0xffffcbc2),
    Color(0xffffbb33),
    Color(0xffa8abff),
    Color(0xfff7f754),
    Color(0xfffac8ff),
  ];

  List<Color> boxColor = [
    Colors.white,
    Color(0xffff757c),
    Color(0xff15bdb1),
    Color(0xff99e6fc),
    Color(0xff49acff),
    Color(0xffa259ff),
    Color(0xffffcbc2),
    Color(0xffffbb33),
    Color(0xffa8abff),
    Color(0xfff7f754),
    Color(0xfffac8ff),
  ];

  final catIndex;

  CatBoxBuilder({this.catIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CategorySpecificData newCat = new CategorySpecificData(
          category: catName[catIndex],
          locked: false,
          exploreIdList: new Map(),
        );
        Navigator.pop(context, newCat);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: boxColor[catIndex],
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(
            color: borderColor[catIndex],
            width: 5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/icons/" + catPic[catIndex],
              width: 50,
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Text(
              catName[catIndex],
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
