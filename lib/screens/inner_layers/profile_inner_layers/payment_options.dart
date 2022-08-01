//import library
import 'package:flutter/material.dart';

//import classes


class PaymentOptionsWidget extends StatefulWidget {

  @override
  _PaymentOptionsWidgetState createState() => _PaymentOptionsWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _PaymentOptionsWidgetState extends State<PaymentOptionsWidget> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ],
        centerTitle: true,
        title: Text(
            'Payment Options'
        ),
      ),
    );
  }
}