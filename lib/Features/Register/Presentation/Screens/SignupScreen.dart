import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messenger_app/Features/Home/Presentation/Screens/MainsScreen.dart';
import 'package:messenger_app/Features/Register/Presentation/Screens/LoginScreen.dart';
import 'package:messenger_app/Features/Register/Presentation/Widgets/CostumeContainer.dart';
import 'package:messenger_app/Features/Register/domain/auth.dart';
import 'package:messenger_app/Features/Register/Presentation/Widgets/image_picker.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

final _formKey = GlobalKey<FormState>();

/// *** validator key *** ////
final RegExp emailRegex = new RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
final _passwordFieldKey = GlobalKey<FormFieldState<String>>();
final TextEditingController _name = TextEditingController();
final TextEditingController _lastname = TextEditingController();
final TextEditingController _email = TextEditingController();
final TextEditingController _pass = TextEditingController();
File _userimage;

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _auth = AuthService();
  //RegisterBloc registerbloc;
  bool _isloading = false;
  @override
  void initState() {
    // registerbloc = BlocProvider.of<RegisterBloc>(context);
    super.initState();
  }

  void _showerror(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('ERROR !'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Ok'),
          )
        ],
      ),
    );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  void _pickedimage(File image) {
    _userimage = image;
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Messa',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'ging',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'App',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),

                    SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          UserImagePicker(_pickedimage),
                          SizedBox(height: 40),
                          TextFormField(
                            controller: _name,
                            decoration: InputDecoration(
                              suffixIcon:
                                  Icon(Icons.person, color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              hintText: 'Enter Your Name !',
                              labelText: 'Name :',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'please enter your Name !';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 15),

                          /// **** Last Name *** //////

                          TextFormField(
                            controller: _lastname,
                            decoration: InputDecoration(
                              suffixIcon:
                                  Icon(Icons.person, color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              hintText: 'Enter Your Last Name !',
                              labelText: 'Last Name :',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please  Enter Your Last Name !';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 15),
                          ////******  Email ****** ////

                          TextFormField(
                            controller: _email,
                            decoration: InputDecoration(
                              suffixIcon:
                                  Icon(Icons.email, color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              hintText: 'Enter Your Email !',
                              labelText: 'Email :',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'please enter your email !';
                              } else if (!emailRegex.hasMatch(value)) {
                                return 'Please enter valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),

                          ////// **** Password **** ////
                          TextFormField(
                            controller: _pass,
                            key: _passwordFieldKey,
                            obscureText: true,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              hintText: 'Enter Your Password',
                              labelText: 'Password :',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            validator: (value) {
                              if (value.length == 0) {
                                return "Please enter password";
                              } else if (value !=
                                  _passwordFieldKey.currentState.value) {
                                return 'Password do not match';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //
                    // login button //
                    _isloading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : TextButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                final email = _email.text;
                                final password = _pass.text;
                                final name = _name.text;
                                final lastname = _lastname.text;
                                final image = _userimage;

                                setState(() {
                                  _isloading = true;
                                });
                                try {
                                  final user = await _auth.signup(
                                      email, password, name, lastname, image);
                                  if (user != null) {
                                    Navigator.of(context).pushReplacement(
                                      new MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return MainScreen();
                                        },
                                      ),
                                    );
                                  }
                                } on FirebaseAuthException catch (e) {
                                  _showerror(e.message);
                                }
                                setState(() {
                                  _isloading = false;
                                });
                              } else {
                                setState(() {
                                  _isloading = false;
                                });
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.grey.shade200,
                                        offset: Offset(2, 4),
                                        blurRadius: 5,
                                        spreadRadius: 2)
                                  ],
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xfffbb448),
                                        Color(0xfff7892b)
                                      ])),
                              child: Text(
                                'Register Now',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                    //
                    SizedBox(height: 10),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 60, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
