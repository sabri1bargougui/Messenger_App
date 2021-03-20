import 'package:flutter/material.dart';
import 'package:messenger_app/Features/Register/Presentation/Screens/LandingScreen.dart';
import 'package:messenger_app/Features/Register/domain/auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthService _auth = AuthService();
  @override
  void initState() {
    _auth.getuserinfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: StreamBuilder(
        stream: _auth.getuserinfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return Stack(
              children: <Widget>[
                Center(
                  child: Image.asset(
                    "assets/images/profile/background3.jpg",
                    fit: BoxFit.cover,
                    width: size.width,
                    height: size.height,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      margin: EdgeInsets.all(0),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      child: Container(
                        height: size.height * 0.45,
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 36,
                                        backgroundImage: NetworkImage(
                                            snapshot.data['avatarurl']),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 8,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              print('ok');
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFE4395F),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: 12,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Edit Profile",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    snapshot.data['name'] +
                                        " " +
                                        snapshot.data['lastname'],
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    snapshot.data['email'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    "Photography",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "I am a UI/UX designer for Website & Mobile who likes to create powerful, pizel perfect designs",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Divider(
                              color: Colors.grey[400],
                            ),
                            TextButton(
                              onPressed: () {
                                _auth.signout().whenComplete(
                                      () =>
                                          Navigator.of(context).pushReplacement(
                                        new MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return WelcomePage();
                                          },
                                        ),
                                      ),
                                    );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFE4395F),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                child: Center(
                                  child: Text(
                                    "LogOut",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(child: Center(child: CircularProgressIndicator()));
          } else {
            return Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.warning),
                  ),
                  Text('Error in loadind data')
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
