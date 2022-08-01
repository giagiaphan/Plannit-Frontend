/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

// import classes
import 'authentication_service.dart';


class PasswordResetWidget extends StatelessWidget {
  // theme setup
  final themeColor = 0xffffcbc2;
  final iconSize = 35.0;

  // setup inputs
  String _email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffff5f5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.clear),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "Đặt lại mật khẩu Plannit",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email của bạn",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onSaved: (input) => _email = input,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            onPressed: () async {
                              _formKey.currentState.validate();
                              _formKey.currentState.save();

                              // Reset password using Firebase
                              context
                                  .read<AuthenticationService>()
                                  .resetPassword(
                                    _email.trim(),
                                  );

                              // automatically popping out of password reset page
                              // when user is verified
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Gửi email đặt mật khẩu mới",
                              style: TextStyle(
                                color: Colors.pink,
                                fontSize: 18,
                              ),
                            ),
                            color: Color(themeColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
