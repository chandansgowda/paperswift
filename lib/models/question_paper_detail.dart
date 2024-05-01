import 'dart:convert';

import 'package:get/get.dart';

class QuestionPaperDetail {
  final List<Department> departments;
  final int count;

  QuestionPaperDetail({
    required this.departments,
    required this.count,
  });

  factory QuestionPaperDetail.fromRawJson(String str) => QuestionPaperDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionPaperDetail.fromJson(Map<String, dynamic> json) => QuestionPaperDetail(
    departments: List<Department>.from(json["departments"].map((x) => Department.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "departments": List<dynamic>.from(departments.map((x) => x.toJson())),
    "count": count,
  };
}

class Department {
  final String name;
  final List<Course> courses;

  Department({
    required this.courses,
    required this.name,
  });

  factory Department.fromRawJson(String str) => Department.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    name: json.keys.first,
    courses: List<Course>.from(json[json.keys.first]["courses"].map((x) => Course.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
  };
}

class Course {
  final String code;
  final String name;
  final int scheme;
  final dynamic syllabusDocUrl;
  final String department;
  final int sem;
  final String status;
  late String paperSetterName;
  late int paperSetterId;

  Course({
    required this.code,
    required this.name,
    required this.scheme,
    required this.syllabusDocUrl,
    required this.department,
    required this.sem,
    required this.status,
    required this.paperSetterName,
    required this.paperSetterId
  });

  factory Course.fromRawJson(String str) => Course.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Course.fromJson(Map<String, dynamic> json) => Course(
      code: json["code"],
      name: json["name"],
      scheme: json["scheme"],
      syllabusDocUrl: json["syllabus_doc_url"],
      department: json["department"],
      sem: json["sem"],
      status: json["assignment_status"],
      paperSetterId: json["paper_setter_id"],
      paperSetterName: json["paper_setter_name"]
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "scheme": scheme,
    "syllabus_doc_url": syllabusDocUrl,
    "department": department,
    "sem": sem,
  };
}