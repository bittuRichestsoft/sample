import 'dart:convert';
import 'dart:io';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:e_canada/AllResponse/LoginResponsePojo.dart';
import 'package:e_canada/api/ApiUrl.dart';
import 'package:e_canada/api/WebApi.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../GlobalUtility.dart';
import 'ForgotPasswordPage.dart';
import 'LoanItems.dart';
import 'SignUpPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {

  String TAG ="LoginPage ";
  String firebaseToken;
  bool _passwordIconVisible = true;
  bool valuefirst = false;
  TextEditingController phone_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  static final GlobalKey<ScaffoldState> _scaffoldkey =
      new GlobalKey<ScaffoldState>();
  String print = "'s";
  LoginResponsePojo loginResponse;
  bool showphoneError = false;
  bool showpassError = false;
  String have = "'ve";
  String dummy = "'t";
  String device_type;
  @override
  void initState() {
    // TODO: implement initState
    getFcmToken();
  //  setRememberUser();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(
        Color(GlobalUtility().hexStringToHexInt("#00ADEF")));
    return Scaffold(
      key: _scaffoldkey,
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
              'Member Login',
              style: TextStyle(
                  color: Color(GlobalUtility().hexStringToHexInt("#00ADEF")),
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text(
              ApiUrl.EmailOrPhone,
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
                    hintText: ApiUrl.EmailOrPhone,
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
            Visibility(
              visible: showphoneError,
              child: Text(
                ApiUrl.validphonenumber,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: MediaQuery.of(context).size.width * 0.02,
                  fontFamily: ApiUrl.UbuntuRegular,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Text(
              ApiUrl.Password,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontFamily: ApiUrl.UbuntuBold,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.left,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.07,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                    Radius.circular(MediaQuery.of(context).size.width * 0.03)),
              ),
              child: TextField(
                controller: password_controller,
                obscureText: _passwordIconVisible,
                textInputAction: TextInputAction.done,
                onChanged: (text) {
                  setState(() {
                    showpassError = false;
                  });
                },
                keyboardType: TextInputType.text,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    decoration: TextDecoration.none,
                    fontFamily: ApiUrl.UbuntuRegular),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15.0),
                  hintText: ApiUrl.Password,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.none,
                      fontFamily: ApiUrl.UbuntuRegular),
                  prefixIcon: IconButton(
                    icon: Icon(
                      Icons.lock_outline,
                      color: Colors.lightBlue,
                      size: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordIconVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.lightBlue,
                      size: MediaQuery.of(context).size.height * 0.03,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordIconVisible = !_passwordIconVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            Visibility(
              visible: showpassError,
              child: Text(
                "Password must be of 8 character or less",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: MediaQuery.of(context).size.width * 0.02,
                  fontFamily: ApiUrl.UbuntuRegular,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            remember_forgot(),
          //  sign_In(),
            smallBtnSignIn(),

            bottom_text()
          ]),
        ),
      ),
    );
  }

  Widget top_logo() {
    return Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.09),
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height * 0.25,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: SvgPicture.asset('assets/images/svg/applogo.svg'),
                  radius: MediaQuery.of(context).size.width * 0.1,
                ),
              ),
            ),
          ],
        ));
  }

  Widget bottom_text() {
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
                      text: 'Don$dummy have an account? ',
                      style: new TextStyle(color: Colors.black),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()),
                          );
                        }),
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

  Widget sign_In() {
    return GestureDetector(
      child: Container(
//        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        decoration: BoxDecoration(
          color: Color(GlobalUtility().hexStringToHexInt("#00ADEF")),
          borderRadius: BorderRadius.all(
              Radius.circular(MediaQuery.of(context).size.height * 0.018)),
        ),
        child: Center(
          child: Text(
            ApiUrl.SIGNIN,
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
         login_user();

      },
    );
  }

  Widget remember_forgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 24.0,
              width: 24.0,
            ),
          ],
        ),
        GestureDetector(
          child: Text(
            ApiUrl.ForgotPassword,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontFamily: ApiUrl.UbuntuBold,
                color: Color(GlobalUtility().hexStringToHexInt("#00ADEF"))),
            textAlign: TextAlign.right,
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
            );
          },
        ),
      ],
    );
  }

  Widget topView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.40 -
          MediaQuery.of(context).padding.top -
          kToolbarHeight,
      color: Color(GlobalUtility().hexStringToHexInt("#00ADEF")),
    );
  }

  Widget back_button() {
    return Align(
        alignment: Alignment.topLeft,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.08,
                    left: MediaQuery.of(context).size.height * 0.03),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ));
  }

  Future login_user() async {
    var check_internet = await GlobalUtility().isConnected();

    FocusScopeNode currentFocus = FocusScope.of(context);

    if (check_internet) {
      if (validate()) {
        if (Platform.isAndroid) {
          device_type = "android";
        } else if (Platform.isIOS) {
          device_type = "ios";
        }
        Map map = {

          "username": phone_controller.text.toString().trim() + "",
          "password": password_controller.text.toString().trim(),
//          "device_type": device_type,
          "version": "1.0" ,//+ PackageInfo().version,
          "action": "userlogin"
        };

        GlobalUtility().showLoaderDialog(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        String apiResponse = await WebApi().register_user(map, "");
        debugPrint("register_apiresponse:---- $apiResponse");
        setState(() {
          showphoneError = false;
          showpassError = false;
          Navigator.of(context).pop();
          var jsondata = json.decode(apiResponse);
          bool success = jsondata['status'];
          var message = jsondata['message'];

          if (success) {
            loginResponse = loginResponseFromJson(apiResponse);
            GlobalUtility().showToast(loginResponse.message);
debugPrint("login response= ${loginResponse.data[0].id}");
            GlobalUtility().setSession(
                loginResponse.data[0].id,
                phone_controller.text,
                loginResponse.data[0].name,
                loginResponse.data[0].email,
            ""
            );

            /*
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CreditPurseHomePage("${loginResponse.data[0].id}")),
            );*/
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoanItems("${loginResponse.data[0].id}")),
            );
          } else {
            GlobalUtility().showSnackBar(message, _scaffoldkey);
            debugPrint("message= ${message}");
          }
        });
      }
    } else {
      GlobalUtility()
          .showSnackBar(ApiUrl.PleaseCheckInternetConnection, _scaffoldkey);
    }
  }

  bool validate() {
    var phone = "" + phone_controller.text.toString();
    var password = "" + password_controller.text.toString();

    if (phone.replaceAll(" ", "") == "") {
      setState(() {
        showphoneError = true;
      });
      return false;
    }
    if (password.replaceAll(" ", "") == "") {
      setState(() {
        showpassError = true;
      });
      return false;
    }
    if (password.length > 8) {
      setState(() {
        showpassError = true;
      });
      return false;
    }

    return true;
  }

  void setRememberUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bool rememberUser = prefs.getBool('IsRemember');
      if (rememberUser) {
        phone_controller.text = prefs.getString("phone");
        password_controller.text = prefs.getString("password");
        valuefirst = true;
      } else {
        phone_controller.text = "";
        password_controller.text = prefs.getString("");
        valuefirst = false;
      }
    });
  }

  smallBtnSignIn() {
return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: (){
             login_user();


        },
        child: Container(
width:MediaQuery.of(context).size.width*0.5  ,
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          decoration: BoxDecoration(
            color: Color(GlobalUtility().hexStringToHexInt("#00ADEF")),
            borderRadius: BorderRadius.all(
                Radius.circular(MediaQuery.of(context).size.height * 0.01)),
          ),  child: Text(
          "SIGN IN",
          style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.height * 0.03,
              fontFamily: ApiUrl.UbuntuBold,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        ),
      ),
    );
  }

  getFcmToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String token = await messaging.getToken();
    firebaseToken = token;
    debugPrint(TAG+" Fcm_token="+firebaseToken);
    GlobalUtility().setFcmToken(firebaseToken);
  }
}
