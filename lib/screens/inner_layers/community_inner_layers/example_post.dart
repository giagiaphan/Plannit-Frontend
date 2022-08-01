//import library
import 'package:flutter/material.dart';

//import classes
import 'package:provider/provider.dart';
import 'package:plannit_frontend/models/community_saved_plans.dart';

class ExamplePostWidget extends StatefulWidget {

  @override
  _ExamplePostWidgetState createState() => _ExamplePostWidgetState();
}


class _ExamplePostWidgetState extends State<ExamplePostWidget> {

  Widget build(BuildContext context) {
    //var savedList = Provider.of<SavedLikedPlans>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: Icon(Icons.favorite_border), onPressed: () {},),
            IconButton(icon: Icon(Icons.add_comment), onPressed: () {},),
            IconButton(icon: Icon(Icons.share), onPressed: () {},),
            IconButton(
              key: Key('save_post'),
              icon: Icon(Icons.save_alt), onPressed: () {
              CommunitySavedPlans.add();
            },),
          ],
        ),
      ),

      body: ListView(
        children: [
          Headline(),
          PlanData(),


          //day 1 starts
          DayDivider(),
          TimeAndActivity(),
          Column(
            children: [
              ReviewWords(),
              ReivewPictures(),
            ],
          ),
          //day 1 ends


          Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, left: 40, right: 20,),
                child: Text(
                  '8AM - 9AM:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, right: 20,),
                child: Text(
                  'Rent-a Car',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 10, left: 100, right: 20,),
            child: Column(
              children: [
                Text(
                  'I rent a car at this car rental place called "Rent-a Car", how cute is that?',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Image.asset(
                      'assets/images/rent_a_caar.jpg',
                      width: 300,
                      height: 230,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, left: 40, right: 20,),
                child: Text(
                  '9AM - 9:45AM:',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, right: 20,),
                child: Text(
                  'Croissant at Gordon\'s',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 10, left: 100, right: 20,),
            child: Column(
              children: [
                Text(
                  'I ordered a croissant from Gordon Ramsey\'s bakery. Gordon even delivered the croissant to me himself. Just, wow!',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Image.asset(
                      'assets/images/croissant_delivery.jpg',
                      width: 300,
                      height: 230,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Headline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Text(
        'Best way to Paris, from an amature traveller\'s perspective',
        style: TextStyle(
          fontSize: 35,
          //fontFamily: 'Salsa',
        ),
      ),
    );
  }
}

class PlanData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  'Duration: 3 days',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Budget:',
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
                  Container(
                    child: Icon(
                      Icons.attach_money,
                    ),
                  ),
                  Container(
                    child: Icon(
                      Icons.attach_money,
                    ),
                  ),
                  Container(
                    child: Icon(
                      Icons.attach_money,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 10),
            alignment: Alignment.centerRight,
            child: Text(
              'by Jessica Wildfire',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DayDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(top: 2, left: 10, right: 10,),
          child: Text(
            'Day 1',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(right: 10,),
                child: Divider(
                  color: Colors.black,
                  height: 50,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TimeAndActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(top: 2, left: 40, right: 20,),
          child: Text(
            '1AM - 8AM:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 2, right: 20,),
          child: Text(
            'Flight to Paris',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class ReviewWords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 100, right: 20,),
      child: Text(
        'I flew with Air France on a First class seat. It was a beautiful and pleasant experience!',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}

class ReivewPictures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 100, right: 20,),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Container(
          child: Image.asset(
            'assets/images/air_france_seat.jpg',
            width: 300,
            height: 230,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}