import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youthconnect/res/custom_colors.dart';
import 'package:youthconnect/database/database.dart';
import 'package:youthconnect/screens/homeScreen.dart';

import 'package:youthconnect/screens/user_info_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity/connectivity.dart';

class SkillTraining extends StatefulWidget {
  const SkillTraining({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;
  @override
  _SkillTrainingState createState() => _SkillTrainingState();
}

class _SkillTrainingState extends State<SkillTraining> {
  late bool _isEmailVerified;
  late User _user;

  Map _messagecomp = {};
  List _startups = ["Damendra", "Faizan", "Kishan", "Ankit"];

  bool _verificationEmailBeingSent = false;
  bool _isSigningOut = false;

  bool _isComposing = false;
  bool checknetConnection = false;
  final TextEditingController _alertTextField = TextEditingController();

  @override
  void initState() {
    super.initState();

    _user = widget._user;
    _isEmailVerified = _user.emailVerified;
  }

  @override
  Widget build(BuildContext context) {
    // Update Body

    // main Activity body

    return Scaffold(
        backgroundColor: CustomColors.buttonColor,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 50,
                      color: CustomColors.firebaseGrey,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget._user.displayName!,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            widget._user.email!,
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ]),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Home'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(user: _user)),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.rate_review),
                title: Text('Skill Training'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SkillTraining(user: _user)),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Account'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserInfoScreen(user: _user)),
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Skill Training"),
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: Container(
          decoration: Theme.of(context).platform == TargetPlatform.iOS //new
              ? BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey[200]!),
                  ),
                )
              : null,
          child: Column(
            children: [
              Flexible(
                child: _startups.isEmpty
                    ? Center(
                        child: CircleAvatar(
                        radius: 100,
                        child: Image.asset("assets/logo.png"),
                      ))
                    : ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: _startups.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            color: Colors.grey[850],
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 0),
                              child: ListTile(
                                title: Text('${_startups[index]}'),
                                onTap: () {},
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    for (var message in _startups) {
      message.dispose();
    }

    super.dispose();
  }
}
