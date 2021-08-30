import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ApiUrl.dart';


class WebApi {

  Future<String> register_user(Map map, url) async{
    var baseUrl = ApiUrl.BASEURL+ url;
    Uri myUri = Uri. parse("$baseUrl" );
    debugPrint("Webapi Url=" + baseUrl + "<<>>params=" + map.toString());

    final response = await http.post(myUri, body: map);

    debugPrint("$url  ApiResponse=" + response.body);

    if (response.statusCode == 200) {
      return response.body;
    }
    else {
      return response.body;
    }
  }
  Future<String> sendOtp(Map map, url) async {
    var baseUrl = ApiUrl.BASEURL+ url;
    Uri myUri = Uri. parse("$baseUrl" );
    debugPrint("Webapi Url=" + baseUrl + "    params " + map.toString());
    final response = await http.post(myUri, body: map,);
    debugPrint("$url  ApiResponse=" + response.body);
    if (response.statusCode == 200) {
      return response.body;
    }
    else {
      return response.body;
    }
  }

  Future<String> getData(url) async {
    url=  ApiUrl.BASEURL + url;
    final response = await http.get(Uri. parse(url));
    debugPrint("$url  ApiResponse="+response.body);
    if (response.statusCode == 200){
      if(response.body.isNotEmpty){
        return response.body;
      }
    }
    else {
      return response.body;
    }
    return "";
  }


}