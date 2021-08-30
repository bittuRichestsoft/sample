import 'package:e_canada/api/ApiUrl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../GlobalUtility.dart';
import 'ApplyLoanWebView2.dart';
import 'CreditPurseHomePage.dart';
import 'LogoutDialog.dart';



String strHoldUsrId="";

class LoanItems extends StatefulWidget {
  LoanItems(holdId){
    strHoldUsrId=holdId;
  }

  @override
  LoanItemsState createState() => LoanItemsState();

}

TabController tabcontroller;
var tab = "";
GlobalKey<ScaffoldState> _scaffoldkey16 = new GlobalKey<ScaffoldState>();

String username="", email="", profilepic="" ;

class LoanItemsState extends State<LoanItems>
    with SingleTickerProviderStateMixin {




  var topHeaderHeight = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionData();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor( Colors.green);
    topHeaderHeight = MediaQuery.of(context).size.height * 0.1;
    /* MediaQuery.of(context).size.height * 0.22 -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;*/
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        key: _scaffoldkey16,
        drawer: NavDrawer(),
        body: Container(
            color: Colors.lightBlueAccent[100] /*Color(GlobalUtility().hexStringToHexInt("#00AAFA"))*/,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: topHeaderHeight/*-MediaQuery.of(context).size.height*0.02*/ ),
                  child: ListView(
                    children: [
                      loanTypesScroll()
                    ],
                  ),
                ),

                Container(
                //  margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.02 ),

                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: topHeaderHeight,
                        color:  Colors.green,
child:  Align(
  alignment: Alignment.center,
  child: Container(
        margin: EdgeInsets.only(
          /*  top: MediaQuery.of(context).size.height * 0.15 -
                MediaQuery.of(context).padding.top -
                kToolbarHeight,*/
            left: MediaQuery.of(context).size.height * 0.02,
            right: MediaQuery.of(context).size.height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Image.asset('assets/images/png/menu.png'),
              onTap: () {
                _scaffoldkey16.currentState.openDrawer();
              },
            ),
            Text(
              "Credit Purse",
              style: TextStyle(
                  color: Colors.white,
                  fontSize:
                  MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(),
            Material(
              color:  Colors.green,
              elevation: 5.0,

              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CreditPurseHomePage(strHoldUsrId,"1")),
                                      );
                },
                child: Container(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01,
                    bottom: MediaQuery.of(context).size.height*0.01,top: MediaQuery.of(context).size.height*0.01,),
                  decoration: BoxDecoration(
                    color: Colors.brown[900],
                    borderRadius: BorderRadius.all(Radius.circular(
                        MediaQuery.of(context).size.height * 0.005)),
                  ),
                  child : Row(
                    children: [
                      Icon(
                        Icons.volunteer_activism,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.035,
                      ),
                      Text(
                        " Loan Status ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                          MediaQuery.of(context).size.width * 0.03,
                          /*fontFamily: Strings.UbuntuBold,*/
                          /*fontWeight: FontWeight.bold*/
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Material(
              color:  Colors.green,
              elevation: 5.0,
              child: GestureDetector(
                onTap: (){
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return LogoutDialog();
                      });

                },
                child: Container(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01,
                    bottom: MediaQuery.of(context).size.height*0.01,top: MediaQuery.of(context).size.height*0.01,),
                  decoration: BoxDecoration(
                    color: Colors.brown[900],
                    borderRadius: BorderRadius.all(Radius.circular(
                        MediaQuery.of(context).size.height * 0.005)),
                  ),
                  child: Row(
                    children: [
                       Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.035,
                      ),
                      Text(
                        " Logout ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                          MediaQuery.of(context).size.width * 0.03,
                          /*fontFamily: Strings.UbuntuBold,*/
                          /*fontWeight: FontWeight.bold*/
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        )),
),
                      ),

                    ],
                  ),
                ),

              ],
            )),
      ),
    );
  }


  loanTypesScroll() {
    return Container(
      color: Colors.lightBlue[100] /*Color(GlobalUtility().hexStringToHexInt("#00ADAF"))*/,
      child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Loans For Every",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontFamily: ApiUrl.UbuntuBold,
                ),
              ),
              Text(
                "Customer",
                style: TextStyle(
                    color: Colors.green,
                    fontFamily: ApiUrl.UbuntuBold,
                    fontSize: MediaQuery.of(context).size.width * 0.08),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Divider(
                  color: Colors.green,
                  height: MediaQuery.of(context).size.height * 0.04,
                  thickness: 4,
                ),
              ),
              item1(),
              item2(),
              item3(),
              SizedBox(height: MediaQuery.of(context).size.height*0.1,)
            ],
          )),
    );
  }

  item1() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              // height: MediaQuery.of(context).size.width*0.4,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.02),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.01),
                  side: BorderSide(
                    color: Colors.black,
                    width: 3,
                  ),
                ),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(
                      'Small Personal Loan', // data[0].title!= null ? data[0].title :"Repairs",
                      style: TextStyle(
                          fontFamily: 'UbuntuRegular',
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          /*  fontWeight: FontWeight.bold,*/
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '\$300-\$2500',
                      style: TextStyle(
                          fontFamily: ApiUrl.UbuntuBold,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        ApiUrl.firstLoanTxt,
                        style: TextStyle(
                            fontFamily: 'UbuntuRegular',
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            /*  fontWeight: FontWeight.bold,*/
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03,
                          bottom: MediaQuery.of(context).size.height * 0.04),
                      child: Material(
                        elevation: 5.0,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.01,
                              bottom: MediaQuery.of(context).size.width * 0.01,
                              left: MediaQuery.of(context).size.width * 0.02,
                              right: MediaQuery.of(context).size.width * 0.02),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.all(Radius.circular(
                                MediaQuery.of(context).size.height * 0.005)),
                          ),
                          child: Text(
                            "  Apply Now  ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                              MediaQuery.of(context).size.height * 0.03,
                              /*fontFamily: Strings.UbuntuBold,*/
                              /*fontWeight: FontWeight.bold*/
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () async {
              navigateToApplyLoan();
            },
          ),
        ),

      ]),
    );
  }

  item2() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              // height: MediaQuery.of(context).size.width*0.4,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.02),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.01),
                  side: BorderSide(
                    color: Colors.black,
                    width: 3,
                  ),
                ),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(
                      'Medium Personal Loan',
                      style: TextStyle(
                          fontFamily: 'UbuntuRegular',
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '\$2500-\$5000',
                      style: TextStyle(
                          fontFamily: ApiUrl.UbuntuBold,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        ApiUrl.secondLoanTxt,
                        style: TextStyle(
                            fontFamily: 'UbuntuRegular',
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            /*  fontWeight: FontWeight.bold,*/
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03,
                          bottom: MediaQuery.of(context).size.height * 0.04),
                      child: Material(
                        elevation: 5.0,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.01,
                              bottom: MediaQuery.of(context).size.width * 0.01,
                              left: MediaQuery.of(context).size.width * 0.02,
                              right: MediaQuery.of(context).size.width * 0.02),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.all(Radius.circular(
                                MediaQuery.of(context).size.height * 0.005)),
                          ),
                          child: Text(
                            "  Apply Now  ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                              MediaQuery.of(context).size.height * 0.03,
                              /*fontFamily: Strings.UbuntuBold,*/
                              /*fontWeight: FontWeight.bold*/
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () async {
              navigateToApplyLoan();
            },
          ),
        ),
       /* Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.01,
                bottom: MediaQuery.of(context).size.width * 0.01,
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02),
            decoration: BoxDecoration(
              color: Colors.green[900],
              borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.height * 0.01)),
            ),
            child: Text(
              "All Rights Reserved",
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.height * 0.025,
                *//*fontFamily: Strings.UbuntuBold,*//*
                *//*fontWeight: FontWeight.bold*//*
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),*/
      ]),
    );
  }

  item3() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              // height: MediaQuery.of(context).size.width*0.4,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.02),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.01),
                  side: BorderSide(
                    color: Colors.black,
                    width: 3,
                  ),
                ),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(
                      'Large Personal Loan', // data[0].title!= null ? data[0].title :"Repairs",
                      style: TextStyle(
                          fontFamily: 'UbuntuRegular',
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          /*  fontWeight: FontWeight.bold,*/
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '\$5000-\$25000',
                      style: TextStyle(
                          fontFamily: ApiUrl.UbuntuBold,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        ApiUrl.thirdLoanTxt,
                        style: TextStyle(
                            fontFamily: 'UbuntuRegular',
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            /*  fontWeight: FontWeight.bold,*/
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03,
                          bottom: MediaQuery.of(context).size.height * 0.04),
                      child: Material(
                        elevation: 5.0,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.01,
                              bottom: MediaQuery.of(context).size.width * 0.01,
                              left: MediaQuery.of(context).size.width * 0.02,
                              right: MediaQuery.of(context).size.width * 0.02),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.all(Radius.circular(
                                MediaQuery.of(context).size.height * 0.005)),
                          ),
                          child: Text(
                            "  Apply Now  ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                              MediaQuery.of(context).size.height * 0.03,
                              /*fontFamily: Strings.UbuntuBold,*/
                              /*fontWeight: FontWeight.bold*/
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () async {
              navigateToApplyLoan();
              },
          ),
        ),
 /*       Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.01,
                bottom: MediaQuery.of(context).size.width * 0.01,
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02),
            decoration: BoxDecoration(
              color: Colors.green[900],
              borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.height * 0.01)),
            ),
            child: Text(
              "All Rights Reserved",
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.height * 0.025,
                *//*fontFamily: Strings.UbuntuBold,*//*
                *//*fontWeight: FontWeight.bold*//*
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      */]),
    );
  }



  Future<void> getSessionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
setState(() {
  username = prefs.getString('name');
  email = prefs.getString('email');
  strHoldUsrId = prefs.getString('sessionId');
  profilepic = prefs.getString("profile_pic");

});

debugPrint("ongetData   username=$username <<>>email=$email  <<>>profilepic=$profilepic<<>>userId=$strHoldUsrId");
  }

  Future<void> navigateToApplyLoan() async {

    var isInternet= await GlobalUtility().isConnected();
    if (isInternet) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ApplyLoanWebView2("${ApiUrl.ApplyLoanUrl}$strHoldUsrId")));


    }
    else {

      showSnackBar("Please check internet connection");
    }

  }

  void showSnackBar(String message) {
    final snackBarContent = SnackBar(
      content: Text(
        message,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
      ),
      action: SnackBarAction(
          label: 'OK',
          onPressed: _scaffoldkey16.currentState.hideCurrentSnackBar),
      duration: Duration(seconds: 5),
    );
    _scaffoldkey16.currentState.showSnackBar(snackBarContent);
  }


}


class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05,
                  left: MediaQuery.of(context).size.width * 0.03,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: EdgeInsets.only(
                                  left:
                                  MediaQuery.of(context).size.width * 0.04,
                                ),
                                child: Icon(
                                  Icons.clear,
                                  color: Color(GlobalUtility()
                                      .hexStringToHexInt("#00ADEF")),
                                ),
                              )),
                          onTap: () {
                            Navigator.of(context).pop();
                              },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                         child: Image.asset(
                           'assets/images/png/credit_purse_logo.png',
                           width: 60,
                           height: 60,
                         )

                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$username",

                                  style: TextStyle(
                                      color: Color(GlobalUtility()
                                          .hexStringToHexInt("#00ADEF")),
                                      fontSize:
                                      MediaQuery.of(context).size.width *
                                          0.04,
                                      fontFamily: 'UbuntuBold'),
                                ),
                                Text(
                                  "$email",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                      MediaQuery.of(context).size.width *
                                          0.025,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'UbuntuRegular'),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                              _scaffoldkey16.currentState.openEndDrawer();
                       //     Navigator.pop(context);
                            /*         Navigator.push(
                              context, MaterialPageRoute(builder: (context) => EditProfilePage("home")),
                            );
                   */
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),


            //Home
            ListTile(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              leading: Icon(
                Icons.home,
                color: Color(GlobalUtility().hexStringToHexInt("#44AEEE")),
                size: MediaQuery.of(context).size.width * 0.08,
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp,
                  color: Color(GlobalUtility().hexStringToHexInt("#00ADEF")),
                  size: MediaQuery.of(context).size.width * 0.035),
              dense: true,
              visualDensity: VisualDensity(horizontal: -1, vertical: -1),
              onTap: () => {
                Navigator.of(context).pop(),
                  //  gotoCreditHomePage(context)

              },
              title: Text(
                'Home',
                style: TextStyle(
                  fontFamily: 'UbuntuBold',
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                ),
              ),
            ),

            //dashboard
            ListTile(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              leading: Icon(
                Icons.dashboard,
                color: Color(GlobalUtility().hexStringToHexInt("#44AEEE")),
                size: MediaQuery.of(context).size.width * 0.08,
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp,
                  color: Color(GlobalUtility().hexStringToHexInt("#00ADEF")),
                  size: MediaQuery.of(context).size.width * 0.035),
              dense: true,
              visualDensity: VisualDensity(horizontal: -1, vertical: -1),
              onTap: () => {
                Navigator.of(context).pop(),

                gotoCreditHomePage(context,"1")

              },
              title: Text(
                'DashBoard',
                style: TextStyle(
                  fontFamily: 'UbuntuBold',
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                ),
              ),
            ),

            //profile
            ListTile(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              leading: Icon(
                Icons.account_box,
                color: Color(GlobalUtility().hexStringToHexInt("#44AEEE")),
                size: MediaQuery.of(context).size.width * 0.08,
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp,
                  color: Color(GlobalUtility().hexStringToHexInt("#00ADEF")),
                  size: MediaQuery.of(context).size.width * 0.035),
              dense: true,
              visualDensity: VisualDensity(horizontal: -1, vertical: -1),
              onTap: () => {
                Navigator.of(context).pop(),

                gotoCreditHomePage(context,"2")

              },
              title: Text(
                'Edit Profile',
                style: TextStyle(
                  fontFamily: 'UbuntuBold',
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                ),
              ),
            ),

            //docs
            ListTile(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              leading: Icon(
                Icons.add_to_photos_rounded,
                color: Color(GlobalUtility().hexStringToHexInt("#44AEEE")),
                size: MediaQuery.of(context).size.width * 0.08,
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp,
                  color: Color(GlobalUtility().hexStringToHexInt("#00ADEF")),
                  size: MediaQuery.of(context).size.width * 0.035),
               dense: true,
              visualDensity: VisualDensity(horizontal: -1, vertical: -1),
              onTap: () => {
                Navigator.of(context).pop(),
                 gotoCreditHomePage(context,"3")

              },
              title: Text(
                'Documents',
                style: TextStyle(
                  fontFamily: 'UbuntuBold',
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                ),
              ),
            ),

            //logout
            ListTile(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              leading: Icon(
                Icons.logout,
                color: Color(GlobalUtility().hexStringToHexInt("#44AEEE")),
                size: MediaQuery.of(context).size.width * 0.08,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontFamily: ApiUrl.UbuntuBold,
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                ),
              ),
              dense: true,
              visualDensity: VisualDensity(vertical: -1),
              onTap: () async => {
                Navigator.of(context).pop(),
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return LogoutDialog();
                    })
              },
            ),
          ],
        ),
      ),
      
    );
  }

  gotoCreditHomePage(context,strPageNmbr) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreditPurseHomePage("$strHoldUsrId",strPageNmbr)));

  }
}
