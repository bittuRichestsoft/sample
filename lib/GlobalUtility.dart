import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'credit/LoginPage.dart';

class GlobalUtility {
  hexStringToHexInt(String hex) {
    hex = hex.replaceFirst('#', '');
    hex = hex.length == 6 ? 'ff' + hex : hex;
    int val = int.parse(hex, radix: 16);
    return val;
  }

  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      debugPrint("mobiletrue");
      return true;
    }

    else if (connectivityResult == ConnectivityResult.wifi) {
      debugPrint("wifitrue");
      return true;
    }
    return false;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  void showSnackBar(String message,GlobalKey<ScaffoldState> _scaffoldkey) {
    final snackBarContent = SnackBar(
      content: Text(
        message,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            fontFamily: 'HKGroteskBold'),
      ),
      action: SnackBarAction(
          label: 'OK',
          onPressed: _scaffoldkey.currentState.hideCurrentSnackBar),
      duration: Duration(seconds: 5),
    );
    _scaffoldkey.currentState.showSnackBar(snackBarContent);
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        textColor: Colors.white,
        backgroundColor: Colors.black,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2);
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Please wait...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  void setSession(String sessionId,String Phonenumber,String username,String user_emaiL, String profilepic/*,bool isaccountadded*/) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('sessionId',sessionId);
    prefs.setString('name',username);
    prefs.setString('email', user_emaiL);
    prefs.setString('phone', Phonenumber);
    prefs.setString('profile_pic', profilepic);
   // prefs.setBool('isAccountadded', isaccountadded);
    debugPrint("session of apiRes=${prefs.getString('name')} , ${prefs.getString('profile_pic')} ");

  }

  void navigateTabhere(String tab) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tab',tab);
  }

  void setFcmToken(String token) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('firebasetoken',token);

  }

  void setRememberUser(bool IsRemember,String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('IsRemember',IsRemember);
    prefs.setString('password',password);
  }
  void setSessionEmpty(BuildContext context)  async
  {

    SharedPreferences prefs2 = await SharedPreferences.getInstance();

        prefs2.clear();


      prefs2.remove('sessionId');
      prefs2.remove('name');
      prefs2.remove('email');
      prefs2.remove('profile_pic');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginPage(),
      ),
          (route) => false,
    );

  }



}