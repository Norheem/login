import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/constants/api_constant.dart';

class HomeRepository {
  Future getJasonData() async {
    try {
      var uri = Uri.parse(ApiConstant.baseUrl);
      var response = await http.get(
        uri,
      );

      if (response.statusCode == 200) {
        print('Success Response body: ${response.body}');
      } else {
        print('Error Response body: ${response.body}');
      }
    } catch (e) {
      debugPrint("error :$e");
    }
  }
}
