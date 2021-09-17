// To parse this JSON data, do
//
//     final loansInfoResponse = loansInfoResponseFromJson(jsonString);

import 'dart:convert';

LoansInfoResponse loansInfoResponseFromJson(String str) => LoansInfoResponse.fromJson(json.decode(str));

String loansInfoResponseToJson(LoansInfoResponse data) => json.encode(data.toJson());

class LoansInfoResponse {
  LoansInfoResponse({
    this.message,
    this.status,
    this.data,
  });

  String message;
  bool status;
  List<Datum> data;

  factory LoansInfoResponse.fromJson(Map<String, dynamic> json) => LoansInfoResponse(
    message: json["message"],
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.description,
    this.minPrice,
    this.maxPrice,
  });

  String id;
  String title;
  String description;
  String minPrice;
  String maxPrice;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    minPrice: json["min_price"],
    maxPrice: json["max_price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "min_price": minPrice,
    "max_price": maxPrice,
  };
}


/*
  void callApiForGetLoanInfo()  async {
    var check_internet = await GlobalUtility().isConnected();

    FocusScopeNode currentFocus = FocusScope.of(context);

    if (check_internet) {



        Map map = {

           "action": "fetch_loan_type"
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
            loansInfoResponse = loansInfoResponseFromJson(apiResponse);
            GlobalUtility().showToast(loansInfoResponse.message);

            debugPrint("login response= ${loansInfoResponse.data[0].id}");


          } else {
            GlobalUtility().showSnackBar(message, _scaffoldkey16);
            debugPrint("message= ${message}");
          }
        });
      }

   else {
      GlobalUtility()
          .showSnackBar(Strings.PleaseCheckInternetConnection, _scaffoldkey16);
    }
  }*/