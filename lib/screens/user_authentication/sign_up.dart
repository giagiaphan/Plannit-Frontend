/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

// import classes
import 'authentication_service.dart';

class SignUpWidget extends StatefulWidget {
  // theme setup
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final themeColor = 0xffffcbc2;

  final iconSize = 35.0;

  final spacing = 15.0;

  String _email, _password, _username, _phone_no;
  bool _passwordVisible;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  bool goodEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Color(0xFF6200EE),
                    ),
                    helperText: 'Để giúp đặt lại mật khẩu lúc bạn quên',
                    suffixIcon: Icon(
                      Icons.mail_outline,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6200EE)),
                    ),
                  ),
                  validator: (val) {
                    if (!goodEmail(val)) {
                      return 'Email của bạn chưa hợp lệ';
                    }
                    return null;
                  },
                  onSaved: (input) => _email = input,
                ),
                Padding(
                  padding: EdgeInsets.only(top: spacing),
                ),
                TextFormField(
                  //obscureText: !_passwordVisible,
                  cursorColor: Theme.of(context).cursorColor,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    labelStyle: TextStyle(
                      color: Color(0xFF6200EE),
                    ),
                    helperText: "Dài ít nhất 8 kí tự",
                    suffixIcon: Icon(Icons.lock),
                    // suffixIcon: GestureDetector(
                    //   onLongPress: () {
                    //     setState(() {
                    //       _passwordVisible = true;
                    //     });
                    //   },
                    //   onLongPressUp: () {
                    //     setState(() {
                    //       _passwordVisible = false;
                    //     });
                    //   },
                    //   child: Icon(_passwordVisible
                    //       ? Icons.visibility
                    //       : Icons.visibility_off),
                    // ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6200EE)),
                    ),
                  ),
                  controller: _pass,
                  validator: (val) {
                    if (val.length < 8) {
                      return 'Mật khẩu phải dài ít nhất 8 kí tự';
                    }
                    return null;
                  },
                  onSaved: (input) => _password = input,
                ),
                Padding(
                  padding: EdgeInsets.only(top: spacing),
                ),
                TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  decoration: InputDecoration(
                    labelText: 'Tên tài khoản',
                    labelStyle: TextStyle(
                      color: Color(0xFF6200EE),
                    ),
                    helperText: "Bạn muốn được gọi là gì?",
                    suffixIcon: Icon(
                      Icons.perm_identity,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6200EE)),
                    ),
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Bạn cần thêm tên tài khoản';
                    }
                    return null;
                  },
                  onSaved: (input) => _username = input,
                ),
                Padding(
                  padding: EdgeInsets.only(top: spacing),
                ),
                TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  decoration: InputDecoration(
                    labelText: 'Số điện thoại',
                    labelStyle: TextStyle(
                      color: Color(0xFF6200EE),
                    ),
                    helperText: "Hứa chỉ gọi 5 phút một lần thôi! :)",
                    suffixIcon: Icon(
                      Icons.phone,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6200EE)),
                    ),
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Bạn cần điền số điện thoại';
                    }
                    return null;
                  },
                  onSaved: (input) => _phone_no = input,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40),
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
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();

                                context.read<AuthenticationService>().signUp(
                                      email: _email.trim(),
                                      password: _password.trim(),
                                      username: _username.trim(),
                                      phone_no: _phone_no.trim(),
                                    );

                                // automatically signing in and popping to User Auth page
                                // for logging in
                                Navigator.pop(context);

                                displayDialog(
                                  context,
                                  "Xác nhận email",
                                  "Bạn vui lòng bấm vào đường link Plannit đã gửi vào email của bạn trước khi đăng nhập lại",
                                );
                              }
                            },
                            child: Text(
                              "Lập kế hoạch thôi!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            color: Colors.deepPurple,
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
