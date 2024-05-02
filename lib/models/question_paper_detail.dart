import 'dart:convert';

class QuestionPaperDetail {
  final List<Department> departments;
  final int count;

  QuestionPaperDetail({
    required this.departments,
    required this.count,
  });

  factory QuestionPaperDetail.fromJson(Map<String, dynamic> json) {
    List<Department> departments = [];
    json.forEach((departmentName, coursesData) {
      departments.add(Department.fromJson({departmentName: coursesData}));
    });
    return QuestionPaperDetail(
      departments: departments,
      count: json.length,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    departments.forEach((department) {
      json[department.name] = department.courses.map((course) => course.toJson()).toList();
    });
    return json;
  }
}

class Department {
  final String name;
  final List<Course> courses;

  Department({
    required this.name,
    required this.courses,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    List<Course> coursesList = [];
    json.forEach((departmentName, coursesData) {
      coursesData.forEach((courseData) {
        coursesList.add(Course.fromJson(courseData));
      });
    });
    return Department(
      name: json.keys.first,
      courses: coursesList,
    );
  }
}

class Course {
  final String code;
  final String name;
  final String paperSetterName;
  final DateTime assignedDate;
  final String status;
  final DateTime submissionDate;
  final String qpDocUrl;
  final String trackingToken;

  Course({
    required this.code,
    required this.name,
    required this.paperSetterName,
    required this.assignedDate,
    required this.status,
    required this.submissionDate,
    required this.qpDocUrl,
    required this.trackingToken,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      code: json['course_id'],
      name: json['course_name'],
      paperSetterName: json['paper_setter'],
      assignedDate: DateTime.parse(json['assigned_date']),
      status: json['status'],
      submissionDate: json['submission_date'] != null ? DateTime.parse(json['submission_date']) : DateTime(0),
      qpDocUrl: json['qp_doc_url'],
      trackingToken: json['tracking_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "course_id": code,
      "course_name": name,
      "paper_setter": paperSetterName,
      "assigned_date": assignedDate.toIso8601String(),
      "status": status,
      "submission_date": submissionDate.toIso8601String(),
      "qp_doc_url": qpDocUrl,
      "tracking_token": trackingToken,
    };
  }
}
