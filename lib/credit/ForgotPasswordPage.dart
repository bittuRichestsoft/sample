import 'dart:convert';
import 'dart:io';

import 'package:e_canada/api/ApiUrl.dart';
import 'package:e_canada/api/WebApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';
/*import 'package:motorchex_app/api/ApiUrl.dart';
import 'package:motorchex_app/api/WebApi.dart';
import 'package:motorchex_app/credit/SignUpPage.dart';
import 'package:motorchex_app/home/Homepage.dart';
import 'package:motorchex_app/registration/VerifyOtpPage.dart';
import 'package:motorchex_app/utility/GlobalUtility.dart';
import 'package:motorchex_app/utility/MaskedInputTextFormatter.dart';
import 'package:motorchex_app/utility/Strings.dart';*/

import '../GlobalUtility.dart';
import 'LoginPage.dart';
import 'SignUpPage.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  ForgotPassword createState() => ForgotPassword();
}

class ForgotPassword extends State<ForgotPasswordPage> {
  bool showphoneError = false;
  TextEditingController phone_controller = TextEditingController();
   GlobalKey<ScaffoldState> _scaffoldkey2 = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(GlobalUtility().hexStringToHexInt("#00ADEF")));
    return Scaffold(
      key: _scaffoldkey2,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: new BoxDecoration(
            color: Colors.grey[100],
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            )),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
          child: ListView(shrinkWrap: true, children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Image.asset(
                'assets/images/png/credit_purse_logo.png',
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.width * 0.1,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Text(
              'Member Forget Password',
              style: TextStyle(
                  color: Color(GlobalUtility().hexStringToHexInt("#00ADEF")),
                  fontSize: MediaQuery.of(context).size.width * 0.06,

                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text("Email",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontFamily: ApiUrl.UbuntuBold,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.left,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height * 0.06,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              child: TextField(
                  controller: phone_controller,
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (text) {
                    setState(() {
                      showphoneError = false;
                    });
                  },
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04),
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: ApiUrl.UbuntuRegular,
                    ),
                    contentPadding: EdgeInsets.all(15.0),
                    border: InputBorder.none,
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.account_box_outlined,
                        color: Colors.lightBlueAccent,
                        size: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  )),
              decoration: BoxDecoration(
                color: Colors.white,
                //borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height *0.025)),
                borderRadius: BorderRadius.all(
                    Radius.circular(MediaQuery.of(context).size.width * 0.03)),
              ),
            ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
             forgetBtn(),
            bottom_signup_text(),
            bottom_signin_text()          ]),
        ),
      ),
    );

  }
  Widget bottom_signup_text() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          margin:
          EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
          child: GestureDetector(
            child: RichText(
              text: new TextSpan(
                style: new TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(
                      text: 'Don\'t have an account? ',
                      style: new TextStyle(color: Colors.black),
                     ),
                  new TextSpan(
                    text: ApiUrl.SignUp,
                    style: new TextStyle(
                        fontFamily: ApiUrl.UbuntuBold,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Color(
                            GlobalUtility().hexStringToHexInt("#44AEEE"))),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
              );
            },
          )),
    );
  }
  Widget bottom_signin_text() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          margin:
          EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
          child: GestureDetector(
            child: RichText(
              text: new TextSpan(
                style: new TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(
                      text: 'Already have an account? ',
                      style: new TextStyle(color: Colors.black),

                         ),
                  new TextSpan(
                    text: ApiUrl.SIGNIN,
                    style: new TextStyle(
                        fontFamily: ApiUrl.UbuntuBold,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Color(
                            GlobalUtility().hexStringToHexInt("#44AEEE"))),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          )),
    );
  }

  Widget forgetBtn() {
    return Align(
      alignment: Alignment.center,

      child: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width*0.5,
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          decoration: BoxDecoration(
            color: Color(GlobalUtility().hexStringToHexInt("#00ADEF")),
            borderRadius: BorderRadius.all(
                Radius.circular(MediaQuery.of(context).size.height * 0.018)),
          ),
          child: Center(
            child: Text(
              "Submit",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                  fontFamily: ApiUrl.UbuntuBold,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        onTap: () {
           callForgetPsdApi();
       //debugPrint("call forget psd api");
        },
      ),
    );
  }
  bool validate() {
var    email= "" + phone_controller.text.toString().trim();
    if (!GlobalUtility().isNumeric(email) &&
        !GlobalUtility().validateEmail(email)) {
      GlobalUtility().showSnackBar("Please enter a valid email", _scaffoldkey2);
      return false;
    }else{
      return true;

    }
    }


  Future callForgetPsdApi() async {
    var check_internet = await GlobalUtility().isConnected();

    FocusScopeNode currentFocus = FocusScope.of(context);

    if (check_internet) {
      if (validate()) {
         Map map = {
          "email": phone_controller.text.toString().trim() + "",
"action":"forget_password"
/*action:forget_password
email:iww.pardeep@gmail.com
*/
          };

        GlobalUtility().showLoaderDialog(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        String apiResponse = await WebApi().register_user(map, "");
        debugPrint("register_apiresponse:---- $apiResponse");
        setState(() {
           Navigator.of(context).pop();
          var jsondata = json.decode(apiResponse);
          bool success = jsondata['status'];
          var message = jsondata['message'];

          if (success) {
setState(() {
  phone_controller.text="";

});

GlobalUtility().showSnackBar(message, _scaffoldkey2);
            debugPrint("message= ${message}");
          }
        });
      }
    } else {
      GlobalUtility()
          .showSnackBar(ApiUrl.PleaseCheckInternetConnection, _scaffoldkey2);
    }
  }
}
