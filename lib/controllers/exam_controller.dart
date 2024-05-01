import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:logger/web.dart';
import 'package:paperswift/models/examination.dart';
import 'package:paperswift/services/api_service.dart';
import 'package:paperswift/utils/constants.dart';


class ExamController extends GetxController{
  final dioOptions =
  BaseOptions(baseUrl: baseUrl, headers: {'accept': 'application/json', 'Content-Type': 'application/json'});
  late final Dio dio;
  late final String? token;
  late ApiService api;
  late FlutterSecureStorage storage;
  RxList<Examination> exams=<Examination>[].obs;
  Logger log = Logger();

  @override
  void onInit() async {
    storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    api=ApiService(token: token);
    await fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      List<Examination> exams_temp=[];
      dynamic response =await api.getAllExams();
      for(dynamic data in response){
       exams_temp.add(Examination.fromJson(data));
      }
      exams.value=exams_temp;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  // Function to create new data entry
  Future<void> createData({
    required String degree,
    required String sem,
    required String scheme,
    required bool isSupplementary,
    required DateTime submissionDeadline,
    required bool isCompleted,
    required String description,
  }) async {
    try {
      dio.options.headers.addAll({'Content-Type': 'application/json',});
      final response = await dio.post(
        'management/exams/',
        data: jsonEncode({
          'degree': degree,
          'sem': sem,
          'scheme': scheme,
          'isSupplementary': isSupplementary,
          'submissionDeadline': submissionDeadline.toIso8601String(),
          'isCompleted': isCompleted,
          'description': description,
        }),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to create data');
      }
    } catch (e) {
      throw Exception('Failed to connect to server');
    }
  }

  // Function to update data entry by ID
  Future<void> updateData(int id, {
    String? degree,
    String? sem,
    String? scheme,
    bool? isSupplementary,
    DateTime? submissionDeadline,
    bool? isCompleted,
    String? description,
  }) async {
    try {
      final response = await dio.patch(
        'management/exams/$id',
        data: jsonEncode({
          'degree': degree,
          'sem': sem,
          'scheme': scheme,
          'isSupplementary': isSupplementary,
          'submissionDeadline': submissionDeadline?.toIso8601String(),
          'isCompleted': isCompleted,
          'description': description,
        }),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update data');
      }
    } catch (e) {
      throw Exception('Failed to connect to server');
    }
  }
  //
  // Function to delete data entry by ID
  Future<void> deleteData(int id) async {
    try {
      final response = await dio.delete('management/exams/$id');
      if (response.statusCode != 204) {
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      throw Exception('Failed to connect to server');
    }
  }
}