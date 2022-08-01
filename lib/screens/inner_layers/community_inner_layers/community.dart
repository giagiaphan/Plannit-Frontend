/// This code belongs to Plannit LLC.
/// Copyright © 2020 by Plannit LLC. All rights reserved.

//import library
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

//import classes
import 'example_post.dart';

class CommunityWidget extends StatefulWidget {
  @override
  _CommunityWidgetState createState() => _CommunityWidgetState();
}

class _CommunityWidgetState extends State<CommunityWidget> {
  Random random = new Random();

  Widget build(BuildContext context) {
    return Scaffold(
      // No appBar property provided, only the body.
      body:
          CustomScrollView(physics: BouncingScrollPhysics(), slivers: <Widget>[
        SliverAppBar(
          centerTitle: true,
          floating: true,
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: [
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
            background: Stack(
              children: [
                SliverAppBarBackground(),
                SliverAppBarSearchBar(),
              ],
            ),
          ),
          expandedHeight: 200,
        ),
        SliverList(
          // Use a delegate to build items as they're scrolled on screen.
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExamplePostWidget()),
                    );
                  },
                  child: PostCard(
                    index: random.nextInt(4),
                  ),
                ),
              );
            },
            childCount: 10,
          ),
        )
      ]),
    );
  }
}

class PostCard extends StatelessWidget {
  List colors = [
    Color(0xffA8ABFF),
    Color(0xffA1D51C),
    Color(0xffFFBE40),
    Color(0xffFF757C),
  ];

  final index;

  PostCard({this.index});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 2,
      child: Card(
        color: colors[index],
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 200,
          ),
          child: Column(
            children: [
              PostDetails(),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Post(),
            ],
          ),
        ),
      ),
    );
  }
}

class Post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        children: [
          PostImage(),
          Padding(
            padding: EdgeInsets.only(left: 5),
          ),
          PostTitleAndSummary(),
        ],
      ),
    );
  }
}

class PostDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserAvatar(),
        Padding(
          padding: EdgeInsets.only(left: 2),
        ),
        Username(),
      ],
    );
  }
}

class PostTitleAndSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle titleTheme = Theme.of(context).textTheme.headline6;
    final TextStyle summaryTheme = Theme.of(context).textTheme.bodyText2;

    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Date night at Ho Guom",
            style: titleTheme,
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Expanded(
            child: Text(
              "Enjoy an incredible night\nat Ho Guom, one of the\nmost iconic attractions\nof Hanoi, Vietnam\nwith your friends and \nfamily.",
              style: summaryTheme,
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }
}

class PostImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        padding: EdgeInsets.only(left: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            //color: Colors.yellow,
            child: Image.asset(
              'assets/images/paris_eiffel.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class Username extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Text(
        "Max Nghja",
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(top: 5),
        child: CircleAvatar(),
      ),
    );
  }
}

class SliverAppBarSearchBar extends StatelessWidget {
  final List<String> list = List.generate(10, (index) => "Text $index");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40, left: 10, right: 10),
      child: RaisedButton(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => SearchView()),
          // );
        },
        color: Colors.white,
        textColor: Colors.black12,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Colors.black,
              ),
              Padding(
                padding: EdgeInsets.only(right: 15),
              ),
              Text("Tìm cảm hứng cho kế hoạch", style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

class SliverAppBarBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        "assets/images/ho_guom.png",
        fit: BoxFit.cover,
      ),
    );
  }
}

class DropDrownInterest extends StatelessWidget {
  final index;

  const DropDrownInterest(
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: Key('more_${index}'),
      icon: Icon(Icons.more_horiz),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return CommunityDropDownWidget();
          },
        );
      },
    );
  }
}
