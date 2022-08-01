/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import classes
import '../../main.dart';
import 'authentication_service.dart';
import 'password_reset.dart';

class SignInWidget extends StatelessWidget {
  // theme setup
  final themeColor = 0xffffcbc2;
  final iconSize = 35.0;

  // setup inputs
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

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
                        "Đăng nhập Plannit với",
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     GestureDetector(
                //       child: Container(
                //         width: iconSize,
                //         height: iconSize,
                //         child: SvgPicture.asset(
                //           'assets/icons/google.svg',
                //         ),
                //       ),
                //     ),
                //     GestureDetector(
                //       child: Container(
                //         width: iconSize,
                //         height: iconSize,
                //         child: SvgPicture.asset(
                //           'assets/icons/facebook.svg',
                //         ),
                //       ),
                //     ),
                //     GestureDetector(
                //       child: Container(
                //         //color: Colors.yellow,
                //         width: iconSize,
                //         height: iconSize,
                //         child: SvgPicture.asset(
                //           'assets/icons/microsoft.svg',
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // Padding(
                //   padding: EdgeInsets.only(top: 20),
                // ),
                // Row(children: <Widget>[
                //   Expanded(
                //     child: new Container(
                //         margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                //         child: Divider(
                //           color: Colors.black,
                //           height: 50,
                //         )),
                //   ),
                //   Text("hoặc"),
                //   Expanded(
                //     child: new Container(
                //         margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                //         child: Divider(
                //           color: Colors.black,
                //           height: 50,
                //         )),
                //   ),
                // ]),
                // Padding(
                //   padding: EdgeInsets.only(top: 20),
                // ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Hãy nhập email của bạn';
                    }
                    return null;
                  },
                  onSaved: (input) => _email = input,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Mật khẩu",
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Hãy nhập mật khẩu của bạn';
                    }
                    return null;
                  },
                  onSaved: (input) => _password = input,
                  obscureText: true,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text("Quên mật khẩu?"),
                  ),
                  onTap: () {
                    // push to forgot password screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PasswordResetWidget()),
                    );
                  },
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

                              context
                                  .read<AuthenticationService>()
                                  .signIn(
                                    email: _email.trim(),
                                    password: _password.trim(),
                                    context: context,
                                  )
                                  .then((value) {
                                if (value == "Signed in") {
                                  Navigator.pop(context);
                                } else {
                                  displayDialog(context, "Lỗi đăng nhập",
                                      "Có vẻ như bạn nhập sai email hoặc mật khẩu");
                                }
                              });
                            },
                            child: Text(
                              "Đăng nhập",
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
