import 'package:flutter/material.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../GlobalUtility.dart';
import 'LoanItems.dart';


class ApplyLoanWebView extends StatefulWidget {
String strApiUrl="";
  ApplyLoanWebView(strUrl){
    strApiUrl=strUrl;
  }

  @override
  _ApplyLoanWebViewState createState() => _ApplyLoanWebViewState(strApiUrl);
}

var globalContext;
class _ApplyLoanWebViewState extends State<ApplyLoanWebView> {
  String strApiUrl2="";
  bool isConnected=true;
  final _key = UniqueKey();
  bool isLoading=true;
  var homeScaffoldKey = GlobalKey<ScaffoldState>();
String TAG="_ApplyLoanWebViewState ";
  String username="", email="", profilepic="",userId ="";

  _ApplyLoanWebViewState(strUrl){
    strApiUrl2=strUrl;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionData();
    if (Platform.isAndroid)
      WebView.platform = SurfaceAndroidWebView();

    debugPrint( TAG+ 'Url_for _api=$strApiUrl2');
  }

  @override
  Widget build(BuildContext context) {
    globalContext=context;
    return Scaffold(
      key: homeScaffoldKey,
       body: Stack(
        children: [
             Container(
margin: EdgeInsets.only(top:  MediaQuery.of(context).size.height * 0.08),
               height: MediaQuery.of(context).size.height*0.92,
                child: Stack(
             children: <Widget>[
             Visibility(
               visible: isConnected,
               child: WebView(
                 key: _key,
                 initialUrl: strApiUrl2,
                 javascriptMode: JavascriptMode.unrestricted,
                 onPageFinished: (finish) {
                   setState(() {
                     isLoading = false;
                   });
                 },
               ),
             ),
          isLoading ? Center( child: CircularProgressIndicator(),)
              : Stack(),
        ],
       ),

    ),
         topHeader()
        ],
      ),
       );

  }

  Future<void> getSessionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('name');
    email = prefs.getString('email');
    userId = prefs.getString('sessionId');

    profilepic = prefs.getString("profile_pic");
    debugPrint("ongetData   username=$username <<>>email=$email  <<>>profilepic=$profilepic<<>>userId=$userId");
  }

  topHeader() {
    return  Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.040),
      margin: EdgeInsets.fromLTRB(0,MediaQuery.of(context).padding.top,0,0),
      color:Colors.green     ,
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoanItems("$userId")));
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.arrow_back,
                  color: Colors.white,
                  size: MediaQuery.of(context)
                      .size
                      .height *
                      0.030,
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
            Text(
              "Apply Loan",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color:Colors.white,
                  fontSize:
                  MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> checkInternet() async {
    var isInternet= await GlobalUtility().isConnected();
    if (isInternet) {
      setState(() {
        isConnected=true;
      });

    }
    else {
      isConnected=false;
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
          onPressed: homeScaffoldKey.currentState.hideCurrentSnackBar),
      duration: Duration(seconds: 5),
    );
    homeScaffoldKey.currentState.showSnackBar(snackBarContent);
  }


}
