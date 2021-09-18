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

