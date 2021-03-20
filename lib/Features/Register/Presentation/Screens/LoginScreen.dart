import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messenger_app/Features/Home/Presentation/Screens/MainsScreen.dart';
import 'package:messenger_app/Features/Register/Presentation/Screens/SignupScreen.dart';
import 'package:messenger_app/Features/Register/Presentation/Widgets/CostumeContainer.dart';
import 'package:messenger_app/Features/Register/domain/auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

final _pass = TextEditingController();
final _email = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  /// *** validator key *** ////
  final RegExp emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  bool _isloading = false;
  //RegisterBloc registerbloc;
  final AuthService _auth = AuthService();
  @override
  void initState() {
    //registerbloc = BlocProvider.of<RegisterBloc>(context);
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

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('f',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Log in with Facebook',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
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
          text: 'Mess',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'aging',
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
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(),
                  SizedBox(height: 50),
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // email //
                          TextFormField(
                            controller: _email,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.mail, color: Colors.black),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              hintText: 'Enter Your Email !',
                              labelText: 'EMAIL :',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'please enter valid email';
                              } else if (!emailRegex.hasMatch(value)) {
                                return 'Please enter valid email';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          // passowrd ///
                          TextFormField(
                            key: _passwordFieldKey,
                            controller: _pass,
                            obscureText: true,
                            decoration: InputDecoration(
                              suffixIcon:
                                  Icon(Icons.security, color: Colors.black),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              hintText: 'Enter Your Password !',
                              labelText: 'Password :',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'please Enter a Password !';
                              } else if (value !=
                                  _passwordFieldKey.currentState.value) {
                                return 'Password do not match';
                              }
                              return null;
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
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
                              setState(() {
                                _isloading = true;
                              });

                              // final res= await _auth.login(email, password).onError(
                              //   (error, stackTrace) =>
                              //    _showerror(error.message));
                              try {
                                final user = await _auth.login(email, password);
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
                              'Login',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                  //
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Password ?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  //
                  _divider(),
                  //
                  _facebookButton(),
                  //
                  SizedBox(height: height * .055),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
          Positioned(top: 60, left: 0, child: _backButton()),
        ],
      ),
    ));
  }
}
