
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:permission_handler/permission_handler.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import '../GlobalUtility.dart';

class ApplyLoanWebView2 extends StatefulWidget {
  String strHoldUrl="";
  ApplyLoanWebView2(String holdUrl) {
    strHoldUrl = holdUrl;
   }
  @override
  ApplyLoanWebView2State createState() => ApplyLoanWebView2State(strHoldUrl);

}

TabController tabcontroller;
var tab = "";
GlobalKey<ScaffoldState> _scaffoldkey16 = new GlobalKey<ScaffoldState>();

String strUsername;
String strEmail;
String strProfilepic;
String strUserId="",strHoldPageNmbr="1";

bool isLoading=true;

WebViewController _webViewController;


class ApplyLoanWebView2State extends State<ApplyLoanWebView2>
    with SingleTickerProviderStateMixin {

  String strHoldUrl="";
  ApplyLoanWebView2State(String holdUrl) {
    strHoldUrl= holdUrl;
   }


  var topHeaderHeight = 0.0;
  var isInternet=true;
    PermissionStatus _permissionStatus = PermissionStatus.denied;
  bool showRetry=false;
  StreamSubscription<ConnectivityResult> _connectivitySubscription;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionData();
    checkInternetConnection();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
    debugPrint("conectivity subscription ${_connectivitySubscription}");
    requestPermission();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    setState(() {
        debugPrint("TAg  $strHoldUrl");
    });

  }

  Future<void> requestPermission() async {
    // final status = await permission.request();
    final status = await Permission.storage.request();
    setState(() {
      print("Status<><><><>-- $status");
      _permissionStatus = status;
      if(status == PermissionStatus.denied) {
        callpermission();
      }
    });
  }

  Future<void> callpermission() async{
    await Permission.storage.request();
  }



  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(
      Colors.green,
    );

    final Set<Factory> gestureRecognizers = [
      Factory(() => EagerGestureRecognizer()),
    ].toSet();

    topHeaderHeight = MediaQuery.of(context).size.height * 0.1;

    /*MediaQuery.of(context).size.height * 0.22 -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;*/
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      key: _scaffoldkey16,
      //drawer: NavDrawer(),
      body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: topHeaderHeight-MediaQuery.of(context).size.height*0.1, /*left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05*/),
                child: isInternet
                    ?
                /* WebView(
        onWebResourceError: (value){
      setState(() {
        isInternet= false;
      });

    },
    gestureRecognizers: gestureRecognizers,
    onWebViewCreated: (controller) {
    _webViewController = controller;
    },
    initialUrl: (urlForWeb != null && urlForWeb!="") ? (  urlForWeb+ strHoldUserId) : '',
                  onPageFinished: (finish) {
                    setState(() {
                      isLoading = false;
                    });


                  },
     )*/
                WebviewScaffold(
                  appBar: AppBar(toolbarHeight: topHeaderHeight,backgroundColor: Colors.white,),
                  url:strHoldUrl,
                  withLocalStorage: true,
                  initialChild: Container(
                      color: Colors.white,
                      child: const Center(
                        child: Text('Loading.....'),
                      )),
                )
                /*    Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
       child: WebviewScaffold(
                    url: baseUrl+strHoldUserId,
         withLocalStorage: true,
         initialChild: Container(
           color: Colors.white,
           child: const Center(
             child: Text('Loading.....'),
                )),
     ))*/: netNotConnected(),
              ),

              isLoading ? Center( child: CircularProgressIndicator(),)
                  : Stack(),
              headerLogoTitle(),
            ],
          )),
    );
  }

  Widget netNotConnected() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Internet not connected. Please try again."),
        retryButton()
      ],
    );
  }

  Widget retryButton() {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        //Center Column contents horizontally,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.065,
            width: MediaQuery.of(context).size.width,
            child: RawMaterialButton(
              onPressed: () {
                checkInternetConnection();
              },
              fillColor: Color(0xffB3C7E6),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Retry',
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: MediaQuery.of(context).size.width * 0.039,
                      fontWeight: FontWeight.bold),
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13)),
            ),
          )
        ],
      ),
    );
  }




  Future<void> getSessionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      strUsername = prefs.getString('name');
      strEmail = prefs.getString('email');
      strUserId = prefs.getString('sessionId');
      strProfilepic = prefs.getString("profile_pic");
    });
    //   checkInternetConnection();
    debugPrint("getSessionData   strUsername=$strUsername <<>>strEmail=$strEmail  <<>>strProfilepic=$strProfilepic<<>>strUserId=$strUserId<<>>strHoldPageNmbr=$strHoldPageNmbr");
  }

  void checkInternetConnection()  async
  {
    var chkInternet = await GlobalUtility().isConnected();

    if (chkInternet) {
      setState(() {
        isInternet = true;
        if(_webViewController!=null) {
          _webViewController.reload();
        }
        isLoading=true;
      });
    } else {
      setState(() {
        isInternet = false;
      });
    }
  }


  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => showRetry = true);
        break;
      default:
        setState(() => showRetry = false);
        break;
    }
  }

  showWeb2nd() {

    return isInternet?Container(
      //   height: MediaQuery.of(context).size.height,
      child: WebviewScaffold(

        url: strHoldUrl,
        allowFileURLs: true,
        debuggingEnabled: true,
        withLocalStorage: true,
        withLocalUrl: true,
        appCacheEnabled: true,
        withJavascript: true,
        withOverviewMode: true,
        hidden: true,
      ),
    ): GestureDetector(
      child:  Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width *0.5,
        height: MediaQuery.of(context).size.height *0.1,
        color: Colors.grey,
        child: Text('Retry',textAlign: TextAlign.center,),
      ),
      onTap: (){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ApplyLoanWebView2("$strHoldUrl")));
      },
    );

  }

  headerLogoTitle() {
    return   Container(
      margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.02 ),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: topHeaderHeight,
            color:  Colors.green,
            child:           Align(
              alignment: Alignment.center,
              child: Container(
                  margin: EdgeInsets.only(
                    /* top: MediaQuery.of(context).size.height * 0.15 -
                        MediaQuery.of(context).padding.top -
                        kToolbarHeight,*/
                      left: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.height * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Icon(Icons.arrow_back,
                          color: Colors.white,
                          size: MediaQuery.of(context)
                              .size
                              .height *
                              0.030,
                        ),/*Image.asset('assets/images/png/menu.png')*/
                        onTap: () {
                          /*  _scaffoldkey16.currentState.openDrawer();*/
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        "Apply Loan",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                            MediaQuery.of(context).size.width * 0.06,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(),
                      /*  Material(
                      color:  Colors.green,
                      elevation: 5.0,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoanItems(strHoldUserId)),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01,
                            bottom: MediaQuery.of(context).size.height*0.004,top: MediaQuery.of(context).size.height*0.004,),
                          decoration: BoxDecoration(
                            color: Colors.brown[900],
                            borderRadius: BorderRadius.all(Radius.circular(
                                MediaQuery.of(context).size.height * 0.005)),
                          ),
                          child: Row(
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
                                  MediaQuery.of(context).size.width * 0.02,
                                  *//*fontFamily: Strings.UbuntuBold,*//*
                                  *//*fontWeight: FontWeight.bold*//*
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),*/
                      SizedBox(),

                      Material(
                        color:  Colors.green,
                        elevation: 5.0,
                        /* child: GestureDetector(
              onTap: (){
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return LogoutDialog();
                    });

              },
              child: Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right: MediaQuery.of(context).size.width*0.02,
                  bottom: MediaQuery.of(context).size.height*0.01,top: MediaQuery.of(context).size.height*0.01,),
                decoration: BoxDecoration(
                  color: Colors.brown[900],
                  borderRadius: BorderRadius.all(Radius.circular(
                      MediaQuery.of(context).size.height * 0.005)),
                ),
                child: Row(
                  children: [
                    *//*  Image.asset('assets/images/png/jobs.png'),*//*
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
                        *//*fontFamily: Strings.UbuntuBold,*//*
                        *//*fontWeight: FontWeight.bold*//*
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          */),

                    ],
                  )),
            ),

          ),
        ],
      ),
    );
  }

}




