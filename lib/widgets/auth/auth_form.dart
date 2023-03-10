import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:marquee/marquee.dart';

import '../pickers/sign_up_image.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);

  //final void Fuction(String email, String password, String username, bool isLogin)submitFn;
  bool isLoading;
  final void Function(String email, String password, String username,
      File? image, bool isLogin, BuildContext ctx) submitFn;
  @override
  State<AuthForm> createState() => _AuthFormState(isLoading);
}

class _AuthFormState extends State<AuthForm> {
  final bool isLoading;
  _AuthFormState(this.isLoading);
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  bool show = true;
  bool presB = false;
  File? userImageFile;
  void _pickedImage(File image) {
    userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context)
        .unfocus(); //close soft keyboard which might still be open after form submission
    //_formKey.currentState?.validate();
    if (userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Plz pick an Image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        userImageFile,
        _isLogin,
        context,
      );
    }
  }

  Color c = Color(0xFFFFFFFF);
  Color t = Color(0xFF42A5F5);

  // bool gone = false;
  //  bool showIt = false;
  //  bool showT = false;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    Color shadowColor = Colors.cyanAccent;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            _isLogin
                ? Image.asset(
              'assets/images/trans_logo.png',
              scale: 4,
            ): SizedBox.shrink(),
            SizedBox(
              height: 1,
            ),
            //_isLogin ?

            Container(
              height: 50,
              // width: 200,
              child: Expanded(
                child: Marquee(
                  //key: Key("$_useRtlText"),
                  // text:
                  // "Slide",
                  // style: TextStyle(
                  //     color: Colors.cyanAccent, fontSize: 30, fontWeight: FontWeight.bold),
                  text: 'S l i d e',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    shadows: [
                      for (double i = 1; i < 8; i++)
                        Shadow(
                          // if(i==3)
                          color: shadowColor,
                          blurRadius: 3 * i,
                        ),
                    ],
                  ),
                  velocity: 10.0,
                  blankSpace: 260,
                ),
              ),
            ),

            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!_isLogin) UserImage(_pickedImage),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        child: Listener(
                          onPointerDown: (_) => setState(() {
                            isPressed = true;
                          }),
                          onPointerUp: (_) => setState(() {
                            isPressed = false;
                          }),
                          child: TextFormField(
                            key: ValueKey('Email'),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !value.contains('@')) {
                                return 'fuck you motherfucker';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              // fillColor: Colors.tealAccent,
                              //   filled: false,
                                focusColor: Colors.teal,
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal),
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30), bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30) )),
                                isDense: true,
                                labelText: 'email',
                                hintText: 'enter email here...',
                                floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                                floatingLabelStyle:
                                const TextStyle(fontSize: 15),
                                labelStyle: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal)),
                            onSaved: (value) {
                              _userEmail = value!;
                            },
                          ),
                        ),
                      ),
                      _isLogin
                          ? SizedBox.shrink()
                          : SizedBox(
                        height: 20,
                      ),
                      _isLogin
                          ? SizedBox.shrink()
                          :  Container(
                        height: 50,
                        child: Listener(
                          onPointerDown: (_) => setState(() {
                            isPressed = true;
                          }),
                          onPointerUp: (_) => setState(() {
                            isPressed = false;
                          }),
                          child: TextFormField(
                            key: ValueKey('Username'),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  value.length < 4) {
                                return 'kheman mani, atleast 4 characters will do';
                              }
                              return null;
                            },
                            //keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal),
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30), bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30) )),
                                isDense: true,
                                labelText: 'username',
                                hintText: 'enter name here...',
                                floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                                floatingLabelStyle:
                                const TextStyle(fontSize: 20),
                                labelStyle: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal)),
                            onSaved: (value) {
                              _userName = value!;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        //width: 135,
                        height: 50,
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  key: ValueKey('Password'),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        value.length < 7) {
                                      return 'Password must be atleast 7 characters';
                                    }
                                    return null;
                                  },
                                  //keyboardType: TextInputType.emailAddress,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.teal),
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30), bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30) )),
                                      isDense: true,
                                      labelText: 'password',
                                      hintText: 'enter password here...',
                                      floatingLabelAlignment:
                                      FloatingLabelAlignment.center,
                                      floatingLabelStyle:
                                      const TextStyle(fontSize: 20),
                                      labelStyle: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.teal)),
                                  obscureText: show,
                                  onSaved: (value) {
                                    _userPassword = value!;
                                  },
                                ),
                              ),
                              presB
                                  ? IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color:
                                  Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    show = !show;
                                    presB = !presB;
                                  });
                                },
                              )
                                  : IconButton(
                                icon: Icon(
                                  Icons.visibility_off_outlined,
                                  color:
                                  Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    show = !show;
                                    presB = !presB;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      if (widget.isLoading) CircularProgressIndicator(),
                      if (!widget.isLoading)
                        Container(
                          width: 155,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: _isLogin ? Colors.lightBlueAccent : Colors.deepOrangeAccent, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _isLogin
                                    ? SizedBox.shrink()
                                    : Icon(
                                  Icons.create,
                                  color:Colors.white,
                                  size: 30,
                                ),
                                Spacer(),
                                Text(
                                  _isLogin ? 'Log in' : 'SignUp',
                                  style: TextStyle(
                                      color:Colors.white,
                                      fontSize: 26),
                                ),
                                _isLogin
                                    ? Icon(
                                  Icons.login,
                                  color: Colors.tealAccent,
                                  size: 30,
                                )
                                    : SizedBox.shrink(),
                              ],
                            ),
                            onPressed: () {
                              _trySubmit();
                              print('ok im pressed');
                            },
                          ),
                        ),
                      SizedBox(
                        height: 5,
                      ),
                      Icon(
                        Icons.compare_arrows,
                        color: Colors.teal,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 118,
                        height: 40,
                        //Small button below upper big button*******************************************************
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: _isLogin ? Colors.deepOrangeAccent :  Colors.lightBlueAccent,// background
                            onPrimary: Colors.white, // foreground
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _isLogin
                                  ? Icon(
                                Icons.create,
                                color: Colors.white,
                                size: 20,
                              )
                                  : SizedBox.shrink(),
                              Spacer(),
                              Text(
                                _isLogin ? 'SignUp' : 'Log in',
                                style: TextStyle(
                                    color:Colors.white,
                                    fontSize: 20),
                              ),
                              _isLogin
                                  ? SizedBox.shrink()
                                  : Icon(
                                Icons.login,
                                color: Colors.tealAccent,
                                size: 30,
                              ),
                            ],
                          ),
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
