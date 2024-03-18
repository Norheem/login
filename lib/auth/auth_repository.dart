import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/models/comment_model.dart';

class AuthRepository {
  Future<ApiResponse?> signupRepo(
      String name, String email, String password) async {
    try {
      var uri = Uri.parse("https://behemoth-api-vercel.vercel.app/auth/signup");

      // var uri = Uri.parse(
      //     'https://delivery-pertners-api-vercel.vercel.app/auth/signup');

      var body = jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      });
      final headers = {
        'Content-Type': 'application/json',
      };

      var response = await http.post(uri, body: body, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          isError: false,
          statusCode: response.statusCode,
          data: response.body,
        );
      } else {
        //error
        return ApiResponse(
          isError: true,
          statusCode: response.statusCode,
          data: response.body,
        );
      }
    } catch (e) {
      debugPrint("error :$e");
      return ApiResponse(isError: true, data: "error $e");
    }
  }
//

  Future<ApiResponse?> signinRepo(String email, String password) async {
    try {
      var uri = Uri.parse("https://behemoth-api-vercel.vercel.app/auth/signin");

      // var uri = Uri.parse(
      //     'https://delivery-pertners-api-vercel.vercel.app/auth/signin');

      //name, email, password ==payload

      var body = jsonEncode({
        "email": email,
        "password": password,
      });
      final headers = {
        'Content-Type': 'application/json',
      };

      var response = await http.post(uri, body: body, headers: headers);

      if (response.statusCode == 200) {
        // print('Success Response body: ${response.body}');
        ////successfull
        ///
        /// Parse the response body
        // var responseData = jsonDecode(response.body);

        return ApiResponse(
          isError: false,
          statusCode: response.statusCode,
          // data: responseData,
          data: response.body,
        );
      } else {
        // print('Error Response body: ${response.body}');
        //error
        return ApiResponse(
          isError: true,
          statusCode: response.statusCode,
          // data: jsonDecode(response.body)['message'],
          data: response.body,
        );
      }
      // return ApiResponse(isError: );
    } catch (e) {
      debugPrint("error :$e");
      return ApiResponse(isError: true, data: "error $e");
    }
  }
//

  Future<ApiResponse?> verifyOtpRepo(
    String otp,
    String email,
  ) async {
    try {
      var uri =
          Uri.parse("https://behemoth-api-vercel.vercel.app/auth/verify-otp");

      // var uri = Uri.parse(
      //     'https://delivery-pertners-api-vercel.vercel.app/auth/signin');

      //name, email, password ==payload

      var body = jsonEncode({
        "otp": otp,
        "email": email,
      });
      final headers = {
        'Content-Type': 'application/json',
      };

      var response = await http.post(uri, body: body, headers: headers);

      log("response from otp:${response.body}");

      if (response.statusCode == 200) {
        // print('Success Response body: ${response.body}');
        ////successfull
        ///
        /// Parse the response body
        // var responseData = jsonDecode(response.body);

        return ApiResponse(
          isError: false,
          statusCode: response.statusCode,
          // data: responseData,
          data: response.body,
        );
      } else {
        // print('Error Response body: ${response.body}');
        //error
        return ApiResponse(
          isError: true,
          statusCode: response.statusCode,
          // data: jsonDecode(response.body)['message'],
          data: response.body,
        );
      }
      // return ApiResponse(isError: );
    } catch (e) {
      debugPrint("error :$e");
      return ApiResponse(isError: true, data: "error $e");
    }
  }
//

  Future<ApiResponse?> resendOtpRepo(
    String email,
  ) async {
    try {
      var uri =
          Uri.parse("https://behemoth-api-vercel.vercel.app/auth/resend-otp");

      // var uri = Uri.parse(
      //     'https://delivery-pertners-api-vercel.vercel.app/auth/signin');

      //name, email, password ==payload

      var body = jsonEncode({
        "email": email,
      });
      final headers = {
        'Content-Type': 'application/json',
      };

      var response = await http.post(uri, body: body, headers: headers);

      log("response from otp:${response.body}");

      if (response.statusCode == 200) {
        // print('Success Response body: ${response.body}');
        ////successfull
        ///
        /// Parse the response body
        // var responseData = jsonDecode(response.body);

        return ApiResponse(
          isError: false,
          statusCode: response.statusCode,
          // data: responseData,
          data: response.body,
        );
      } else {
        // print('Error Response body: ${response.body}');
        //error
        return ApiResponse(
          isError: true,
          statusCode: response.statusCode,
          // data: jsonDecode(response.body)['message'],
          data: response.body,
        );
      }
      // return ApiResponse(isError: );
    } catch (e) {
      debugPrint("error :$e");
      return ApiResponse(isError: true, data: "error $e");
    }
  }
//

  Future<ApiResponse<List<CommentModel>>> getComment() async {
    print("comment called");
    try {
      var uri =
          Uri.parse("https://jsonplaceholder.typicode.com/posts/1/comments");

      final headers = {'Content-Type': 'application/json'};

      var response = await http.get(uri, headers: headers);
      final commentModel = commentModelFromJson(response.body);

      //jsonEncode(respose.body)

      if (response.statusCode == 200) {
        // List<dynamic> jsonList = json.decode(response.body);
        // List<CommentModel> commentModel =
        //     jsonList.map((e) => CommentModel.fromJson(e)).toList();
        print(commentModel);

        return ApiResponse(
          isError: false,
          statusCode: response.statusCode,
          data: commentModel,

          // return ApiResponse(
          //   isError: false,
          //   statusCode: response.statusCode,
          //   data: commentModel,

          //
        );
      } else {
        // print("error res ${response.body}");

        // return ApiResponse(
        //   isError: true,
        //   statusCode: response.statusCode,
        //   data: commentModel,
        // );

        return ApiResponse(
          isError: true,
          statusCode: response.statusCode,
          data: [],
        );
      }
    } catch (e) {
      // List<CommentModel> comment = [];
      // return ApiResponse(isError: false, statusCode: 500, data: comment);

      return ApiResponse(
        isError: true,
        statusCode: 500,
        data: [],
      );
    }
  }
}

class ApiResponse<T> {
  final int? statusCode; //response.statuscode
  final bool isError; //false/true
  final T? data; //response.body

  ApiResponse({
    this.statusCode,
    required this.isError,
    this.data,
  });
}
