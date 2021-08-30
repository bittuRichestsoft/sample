import 'dart:convert';
import 'package:e_canada/api/ApiUrl.dart';
import 'package:e_canada/api/WebApi.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../GlobalUtility.dart';
import 'LoginPage.dart';

class LogoutDialog extends StatefulWidget {
  @override
  Logout createState() => Logout();
}

class Logout extends State<LogoutDialog> {
  static final GlobalKey<ScaffoldState> _scaffoldkey11 = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey11,
      backgroundColor: Colors.transparent,
      body: logOut(),
    );
  }

 Widget logOut()  {
  return AlertDialog(
    backgroundColor: Color(GlobalUtility().hexStringToHexInt("#E8ECF2")),
     title: Text('Confirm logout',style: TextStyle(fontFamily:ApiUrl.UbuntuBold,color: Color(GlobalUtility().hexStringToHexInt("#00A8E8")),fontSize: 16.0),),
     content: SingleChildScrollView(
       child: ListBody(
         children: <Widget>[
           Text('Are you sure you want to logout?',style: TextStyle(fontFamily:ApiUrl.UbuntuBold,color: Color(GlobalUtility().hexStringToHexInt("#00A8E8")),fontSize: 14.0),),
         ],
       ),
     ),
     actions: <Widget>[
       
       Container(
         decoration: BoxDecoration(

           borderRadius: BorderRadius.all(Radius.circular(
               MediaQuery.of(context).size.width * 0.04)),
           border: Border.all(
               width: 1.0,
               color: Color(GlobalUtility().hexStringToHexInt("#00A8E8"))),
         ),
         child: FlatButton(
           child: Text('Cancel',style: TextStyle(color: Color(GlobalUtility().hexStringToHexInt("#00A8E8")),fontSize: 14.0),),
           onPressed: () {
             Navigator.of(context).pop();
           },
         ),
       ),
       Container(
         decoration: BoxDecoration(
           color: Color(GlobalUtility().hexStringToHexInt("#00A8E8")),
           borderRadius: BorderRadius.all(Radius.circular(
               MediaQuery.of(context).size.width * 0.04)),
         ),
         child: FlatButton(
           child: Text('Ok',style: TextStyle(color: Colors.white,fontSize: 14.0)),
           onPressed: () {
           //  logoutUser();// Navigate to login
             GlobalUtility().setSessionEmpty(context);
             Navigator.pushAndRemoveUntil(
               context,
               MaterialPageRoute(
                 builder: (BuildContext context) => LoginPage(),
               ),
                   (route) => false,
             );
           },
         ),
       ),
     ],
   );
  }
  Future logoutUser() async {

    var check_internet = await GlobalUtility().isConnected();

    if (check_internet) {

      SharedPreferences prefs = await SharedPreferences.getInstance();

      String sessionId=prefs.getString("sessionId");

      if(sessionId.isNotEmpty) {

        Map map = {
          "session_id": sessionId
        };
        GlobalUtility().showLoaderDialog(context);
        String apiResponse = await WebApi().register_user(map, ApiUrl.LOGOUTUSER);
        debugPrint("register_apiresponse:---- $apiResponse");
        setState(() {
        Navigator.of(context).pop();
        var jsondata = json.decode(apiResponse);
        int status = jsondata['status'];
        var message = jsondata['message'];
        if (status==200) {
          GlobalUtility().setSessionEmpty(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => LoginPage(),
            ),
                (route) => false,
          );
        }
        else {
          GlobalUtility().showSnackBar(message,_scaffoldkey11);
          debugPrint("message=${message}");
        }
        });
      }
    }
    else{
      GlobalUtility().showSnackBar("Please check your internet connection",_scaffoldkey11);
    }
  }
}