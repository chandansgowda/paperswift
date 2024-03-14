import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:paperswift/utils/constants.dart';

class ApiService {
  final dioOptions =
      BaseOptions(baseUrl: baseUrl, headers: {'accept': 'application/json', 'Content-Type': 'application/json'});

  late final Dio dio;
  late final String? token;

  ApiService({this.token}) {
    dio = Dio(dioOptions);
    if (token != null) {
      dio.options.headers.addAll({'Authorization': 'Token $token'});
    }
  }

  Future<dynamic> login(var data) async {
    var response = await dio.post('auth/login/', data: data);
    if (response.statusCode == 200) {
      var jsonResponse = response.data;
      print(jsonResponse);
      String token = jsonResponse['key'];
      return token;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future<bool> logout() async {
    var response = await dio.post('auth/logout/');
    if (response.statusCode == 200) {
      var jsonResponse = response.data;
      print(jsonResponse['detail']);
      return true;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
  }

  Future<bool> isTokenValid() async {
    Response response = await dio.get('auth/user/');
    if (response.statusCode == 200) {
      var jsonResponse = response.data;
      if (jsonResponse.containsKey('pk')) {
        // Token is valid
        return true;
      } else {
        // Token is invalid
        return false;
      }
    } else {
      // Handle error responses here
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
  }

  Future<dynamic> getAllExams() async {
    final response = await dio.get('management/exams/');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load data');
    }
  }
  
  Future<dynamic> getExaminationDetails(int examId) async{
    final response=await dio.get('management/get_dept_and_teachers_for_exam/$examId');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<dynamic> getDegreesDetails() async{
    final response=await dio.get('management/get_degree_and_schemes');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<dynamic> postNewExam(var data) async{
    print(dioOptions.headers);
    final response=await dio.post('management/exams/',data: data);
    if (response.statusCode == 201) {
      print("Successfully created exam");
      return response.data;
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<dynamic> postBulkPaperSetters(var data) async{
    final response=await dio.post('assignment/bulk_assign_paper_setters',data: data);
    if (response.statusCode == 200) {
      print("Successfully added bulk setters");
      return response.data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
