


import 'dart:convert';

LoginResponsePojo loginResponseFromJson(String str) => LoginResponsePojo.fromJson(json.decode(str));

String loginResponsePojoString(LoginResponsePojo data) => json.encode(data.toJson());

class LoginResponsePojo {
  String message;
  bool status;
  List<Data> data;

  LoginResponsePojo({this.message, this.status, this.data});

  LoginResponsePojo.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String name;
  String email;
  String username;
  String phone;
  String password;
  String status;
  String passwordShw;
  String devicetype;
  String devicetoken;
  String version;
  String regVia;
  String createdOn;

  Data(
      {this.id,
        this.name,
        this.email,
        this.username,
        this.phone,
        this.password,
        this.status,
        this.passwordShw,
        this.devicetype,
        this.devicetoken,
        this.version,
        this.regVia,
        this.createdOn});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
    password = json['password'];
    status = json['status'];
    passwordShw = json['password_shw'];
    devicetype = json['devicetype'];
    devicetoken = json['devicetoken'];
    version = json['version'];
    regVia = json['reg_via'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['status'] = this.status;
    data['password_shw'] = this.passwordShw;
    data['devicetype'] = this.devicetype;
    data['devicetoken'] = this.devicetoken;
    data['version'] = this.version;
    data['reg_via'] = this.regVia;
    data['created_on'] = this.createdOn;
    return data;
  }
}