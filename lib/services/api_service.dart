import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:paperswift/utils/constants.dart';

class ApiService {
  final dioOptions = BaseOptions(
    baseUrl: baseUrl,
    headers: {'accept': 'application/json', 'Content-Type': 'application/json'},
  );

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

  Future<dynamic> getExaminationDetails(int examId) async {
    final response = await dio.get('management/get_teachers_and_courses_for_exam/$examId');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> getDegreesDetails() async {
    final response = await dio.get('management/get_degree_and_schemes');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> postNewExam(var data) async {
    print(dioOptions.headers);
    try {
      final response = await dio.post('management/exams/', data: data);
      if (response.statusCode == 201) {
        print("Successfully created exam");
        return response.data;
      }
    } on DioException catch (e) {
      print(e);
      throw Exception('Failed to load data: ${e.toString()}');
    }
  }

  Future<dynamic> postBulkPaperSetters(var data) async {
    final response = await dio.post('assignment/bulk_assign_paper_setters', data: data);
    if (response.statusCode == 200) {
      print("Successfully added bulk setters");
      return response.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> postComment(var data) async {
    final response = await dio.post('assignment/comment', data: data);
    if (response.statusCode == 200) {
      print("Successfully posted comment");
      return response.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> acceptPaper(var data) async {
    final response = await dio.post('assignment/accept_question_paper', data: data);
    if (response.statusCode == 200) {
      print("Accepted the paper");
      return response.data;
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<dynamic> getQuestionPaperDetails(int examId) async {
    final response = await dio.get('assignment/submitted_papers/$examId');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> fetchReport() async {
    final response = await dio.get('assignment/report');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> sendReminder(var data) async {
    final response = await dio.post('assignment/send_reminder',data: data);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
