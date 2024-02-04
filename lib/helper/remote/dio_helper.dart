import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.1.5:80',
        receiveDataWhenStatusError: true,

        /// If you want to handle the headers HERE"
        // headers: {
        //   'Content-Type': 'application/json',
        //   'lang': 'ar',
        // },
      ),
    );
  }

  static Future<Response> getData(
      {@required String? url, Map<String, dynamic> ?query, lang, token}) async {
    if(token != null){
      dio!.options.headers["Authorization"] = 'Bearer $token';
    }
    return await dio!.get(url!, queryParameters: query);
  }

  static Future<Response> postData(
      {@required url, query, @required data, lang = 'ar', token}) async {
    if(token != null){
      dio!.options.headers["Authorization"] = 'Bearer $token';
    }
    return await dio!.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData({@required String? url,@required data,token}) async {
    // print(token.toString());
    // if(token != null){
      dio!.options.headers["Authorization"] = 'Bearer $token';
      // dio.options.headers['Content-Type']= 'multipart/form-data';

    // }


    return await dio!.put(url!,data: data,);
  }

  static Future<Response> putImage({@required String? url,@required data,token}) async {
    // print(token.toString());
    // if(token != null){
    dio!.options.headers["Authorization"] = 'Bearer $token';
    dio!.options.headers['Content-Type']= 'multipart/form-data';

    // }


    return await dio!.put(url!,data: data,);
  }
  static Future<Response> postImage(
      {@required url, query, @required data, lang = 'ar', token}) async {
    if(token != null){
      dio!.options.headers["Authorization"] = 'Bearer $token';
    }
    dio!.options.headers['Content-Type']= 'multipart/form-data';
    return await dio!.post(url, queryParameters: query, data: data);
  }

  static Future<Response> deleteData({@required url,data,token})async{
    if(token != null){
      dio!.options.headers["Authorization"] = 'Bearer $token';
    }
    return dio!.delete(url,data: data);
  }
}