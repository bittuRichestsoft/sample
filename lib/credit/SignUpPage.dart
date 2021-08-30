import 'dart:convert';
import 'dart:io';

import 'package:e_canada/AllResponse/LoginResponsePojo.dart';
import 'package:e_canada/api/ApiUrl.dart';
import 'package:e_canada/api/WebApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';


import '../GlobalUtility.dart';
import '../MaskedInputTextFormatter.dart';
import 'CreditPurseHomePage.dart';
import 'LoanItems.dart';
import 'LoginPage.dart';

class SignUpPage extends StatefulWidget {
  @override
  SignUp createState() => SignUp();
}

class SignUp extends State<SignUpPage> {
  String firebaseToken;
  bool _passwordIconVisible = true;
  bool confirm_passwordIconVisible = true;
  TextEditingController email_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController fullname_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController confirm_password_controller = TextEditingController();
  LoginResponsePojo regResponse;


  static final GlobalKey<ScaffoldState> _scaffoldkey4 = new GlobalKey<ScaffoldState>();

  String device_type, devicetoken;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  getFcmToken();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(
        Color(GlobalUtility().hexStringToHexInt("#00ADEF")));
    return Scaffold(
      key: _scaffoldkey4,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // margin: EdgeInsets.only(
        //     top: MediaQuery.of(context).size.height * 0.34 -
        //         MediaQuery.of(context).padding.top -
        //         kToolbarHeight),
        //child: new Container(
        decoration: new BoxDecoration(
            color: Colors.grey[100],
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            )),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.001,
            left: MediaQuery.of(context).size.width * 0.02,
            right: MediaQuery.of(context).size.width * 0.02,
            bottom: 0.0),
            shrinkWrap: true,
            children: [
          /////////////////// fullname widget/////////////////////////////////
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
                'Member Sign Up',
                style: TextStyle(
                    color: Color(GlobalUtility().hexStringToHexInt("#00ADEF")),
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                'Create you account. it\'s free and only takes a minute.',
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                     decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
            'Name',
            style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontFamily: 'UbuntuBold',
                decoration: TextDecoration.none),
            textAlign: TextAlign.left,
          ),

          fullname_field(),
          ///////////////mail widget/////////////////
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          Text(
            'Email',
            style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontFamily: 'UbuntuBold',
                decoration: TextDecoration.none),
            textAlign: TextAlign.left,
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01),
            decoration: BoxDecoration(
              color:
                  Colors.white ,
              borderRadius: BorderRadius.all(Radius.circular(
                  MediaQuery.of(context).size.width * 0.03)),
            ),
            child: TextField(
                controller: email_controller,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15.0),
                  hintText: 'Email Address',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'UbuntuRegular',
                  ),
                  border: InputBorder.none,
                  prefixIcon: IconButton(
                    icon: Icon(
                      Icons.mail_outline_rounded,
                      color: Color(
                          GlobalUtility().hexStringToHexInt("#00ADEF")),
                      size: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ),
                )),
          ),
          /////////////////Phone number widget///////////
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          Text(
            'Phone Number',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'UbuntuBold',
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none),
            textAlign: TextAlign.left,
          ),

          phone_field(),
          /////////////password///////////////
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          Text(
            'Password',
            style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontFamily: 'UbuntuBold',
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none),
            textAlign: TextAlign.left,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.01),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(
                  MediaQuery.of(context).size.width * 0.03)),
            ),
            child: TextField(
              controller: password_controller,
              obscureText: _passwordIconVisible,
              textInputAction: TextInputAction.done,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  decoration: TextDecoration.none,
                  fontFamily: 'UbuntuRegular'),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'Password',
                border: InputBorder.none,
                hintStyle: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.none,
                    fontFamily: 'UbuntuRegular'),
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

          //////confirm password
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Text(
                'Confirm Password',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontFamily: 'UbuntuBold',
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none),
                textAlign: TextAlign.left,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.01),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(
                      MediaQuery.of(context).size.width * 0.03)),
                ),
                child: TextField(
                  controller: confirm_password_controller,
                  obscureText: confirm_passwordIconVisible,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      decoration: TextDecoration.none,
                      fontFamily: 'UbuntuRegular'),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15.0),
                    hintText: 'Password',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.none,
                        fontFamily: 'UbuntuRegular'),
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.lock_outline,
                        color: Colors.lightBlue,
                        size: MediaQuery.of(context).size.height * 0.03,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        confirm_passwordIconVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.lightBlue,
                        size: MediaQuery.of(context).size.height * 0.03,
                      ),
                      onPressed: () {
                        setState(() {
                          confirm_passwordIconVisible = !confirm_passwordIconVisible;
                        });
                      },
                    ),
                  ),
                ),
              ),


          //////////SignUp widget////////////
          signup_widget(),
          bottomText(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            ],
          ),
        ),
      ),
    );
  }

  Widget sign_applogo() {
    return Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
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

  Widget bottomText() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
          child: GestureDetector(
            child: RichText(
              text: new TextSpan(
                style: new TextStyle(
                  fontFamily: 'UbuntuBold',
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(
                      text: 'Already have an account? ',
                      style: new TextStyle(color: Colors.black)),
                  new TextSpan(
                    text: ApiUrl.SIGNIN,
                    style: new TextStyle(
                        fontFamily: 'UbuntuBold',
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

  Widget signup_widget() {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        child: Container(
          width:MediaQuery.of(context).size.width*0.5  ,
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          decoration: BoxDecoration(
            color: Color(GlobalUtility().hexStringToHexInt("#00ADEF")),
            borderRadius: BorderRadius.all(
                Radius.circular(MediaQuery.of(context).size.width * 0.03)),
          ),
          child: Text(
            ApiUrl.SignUp,
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.04,
              fontFamily: 'UbuntuBold',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        onTap: () {
          registerUser();

        },
      ),
    );
  }

  Widget topview() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.40 -
          MediaQuery.of(context).padding.top -
          kToolbarHeight,
      color: Color(GlobalUtility().hexStringToHexInt("#00ADEF")),
    );
  }

  Widget fullname_field() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
            Radius.circular(MediaQuery.of(context).size.width * 0.03)),
      ),
      child: TextField(
          controller: fullname_controller,
          textInputAction: TextInputAction.next,
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15.0),
            hintText: 'Full Name',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontFamily: 'UbuntuRegular',
            ),
            border: InputBorder.none,
            prefixIcon: IconButton(
              icon: Icon(
                Icons.person_outline,
                color: Color(GlobalUtility().hexStringToHexInt("#44AEEE")),
                size: MediaQuery.of(context).size.height * 0.03,
              ),
            ),
          )),
    );
  }

  Widget phone_field() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
            Radius.circular(MediaQuery.of(context).size.width * 0.03)),
      ),
      child: TextField(
          controller: phone_controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            MaskedInputTextFormatter(
              mask: '1234567890',
              separator: '',
            ),
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
          ],
          textInputAction: TextInputAction.next,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.04,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15.0),
            hintText: 'Phone number',
            hintStyle:
                TextStyle(color: Colors.grey, fontFamily: 'UbuntuRegular'),
            border: InputBorder.none,
            prefixIcon: IconButton(
              icon: Icon(
                Icons.phone_android,
                color: Color(GlobalUtility().hexStringToHexInt("#44AEEE")),
                size: MediaQuery.of(context).size.height * 0.03,
              ),
            ),
          )),
    );
  }

  Future registerUser() async {
    var check_internet = await GlobalUtility().isConnected();
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (check_internet) {
      if (validate()) {
        var fullname = "" + fullname_controller.text.toString();
        var password = "" + password_controller.text.toString();
        var email = "" + email_controller.text.toString();
        var phonenumber = "" + phone_controller.text.toString();
        GlobalUtility().showLoaderDialog(context);
        if (Platform.isAndroid) {
          device_type = "android";
        } else if (Platform.isIOS) {
          device_type = "ios";
        }
/*action:signup_user
email:iww.pardeep01@gmail.com
password:1234
name:testt
phone:8527418865
devicetype:android
devicetoken:egeghhg
version:1.5
reg_via:app*/
        Map map = {
          "email": ""+email_controller.text.toString().trim(),
          "password": ""+password_controller.text.toString(),
       "name":""+fullname_controller.text.toString(),
       "phone":""+phone_controller.text.toString(),
          "devicetype":"android",
          "devicetoken":"egeghhg",
           "version": "1.0" ,
          "action": "signup_user",
          "reg_via":device_type

        };

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        String apiResponse =
            await WebApi().register_user(map,"");
        debugPrint("register_apiresponse:---- $apiResponse");
        setState(() {
          Navigator.of(context).pop();
          var jsondata = json.decode(apiResponse);
          bool success = jsondata['status'];
          var message = jsondata['message'];

          if (success) {
            regResponse = loginResponseFromJson(apiResponse);
            GlobalUtility().showToast(regResponse.message);

            GlobalUtility().setSession(
                regResponse.data[0].id,
                phone_controller.text,
                regResponse.data[0].name,
                regResponse.data[0].email,
                ""
            );

           /* Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CreditPurseHomePage("${regResponse.data[0].id}")),
            );*/
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoanItems("${regResponse.data[0].id}")),
            );


          } else {
            GlobalUtility().showSnackBar(message, _scaffoldkey4);
            debugPrint("message=${message}");
          }
        });
      }
    } else {
      GlobalUtility()
          .showSnackBar("Please check your internet connection", _scaffoldkey4);
    }
  }

  bool validate() {
    var fullname = "" + fullname_controller.text.toString();
    var password = "" + password_controller.text.toString();
    var confirm_password = "" +confirm_password_controller.text.toString();
    var email = "" + email_controller.text.toString();
    var phonenumber = "" + phone_controller.text.toString();

    if (fullname.replaceAll(" ", "") == "") {
      GlobalUtility()
          .showSnackBar("Please enter your full name", _scaffoldkey4);
      return false;
    } else   if (!GlobalUtility().isNumeric(email) &&
        !GlobalUtility().validateEmail(email)) {
      GlobalUtility().showSnackBar("Please enter a valid email", _scaffoldkey4);
      return false;
    } else if (phonenumber.replaceAll(" ", "") == "") {
      GlobalUtility().showSnackBar("Please enter phone number", _scaffoldkey4);
      return false;
    }if (phonenumber.length != 10) {
      GlobalUtility()
          .showSnackBar("Please enter a valid phone number", _scaffoldkey4);
      return false;
    } else if (password.replaceAll(" ", "") == "") {
      GlobalUtility().showSnackBar("Please enter password", _scaffoldkey4);
      return false;
    } else      if (password.length < 8) {
      GlobalUtility().showSnackBar(
          "Password length must be of 8 characters", _scaffoldkey4);
      return false;
    }else      if (password!=confirm_password) {
      GlobalUtility().showSnackBar(
          "Password is not confirmed", _scaffoldkey4);
      return false;
    }

    return true;
  }
/*  getFcmToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String token = await messaging.getToken();
    firebaseToken = token;
    debugPrint("Fcm token:" + firebaseToken);
  }*/
}
