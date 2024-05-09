import 'dart:convert';

import 'package:get/get.dart';

class ExaminationDetail {
  final List<Department> departments;
  final int count;
  final int assignmentStatus;

  ExaminationDetail({
    required this.departments,
    required this.count,
    required this.assignmentStatus,
  });

  factory ExaminationDetail.fromJson(Map<String, dynamic> json) {
    final List<Department> departments = [];
    json['departments'].forEach((key, value) {
      departments.add(Department.fromJson({key:value}));
    });

    return ExaminationDetail(
      departments: departments,
      count: json["count"],
      assignmentStatus: json["assignment_status"],
    );
  }
}

class Department {
  final String name;
  final List<Course> courses;

  Department({
    required this.courses,
    required this.name,
  });

  factory Department.fromRawJson(String str) => Department.fromJson(json.decode(str));


  factory Department.fromJson(Map<String, dynamic> json) => Department(
    name: json.keys.first,
    courses: List<Course>.from(json[json.keys.first].map((x) => Course.fromJson(x))),
  );


}

class Course {
  final String code;
  final String name;
  final int scheme;
  final dynamic syllabusDocUrl;
  final String department;
  final int sem;
  final String status;
  late RxString paperSetterName;
  late int paperSetterId;
  late int assignmentId;
  final List<PaperSetter> paperSetters;

  Course({
    required this.code,
    required this.name,
    required this.scheme,
    required this.syllabusDocUrl,
    required this.department,
    required this.sem,
    required this.status,
    required this.paperSetterName,
    required this.paperSetterId,
    required this.assignmentId,
    required this.paperSetters
  });

  factory Course.fromRawJson(String str) => Course.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    code: json["course"]["code"],
    name: json["course"]["name"],
    scheme: json["course"]["scheme"],
    syllabusDocUrl: json["course"]["syllabus_doc_url"],
    department: json["course"]["department"],
    sem: json["course"]["sem"],
    status: json["course"]["assignment_status"],
    paperSetterId: json["course"]["paper_setter_id"],
    assignmentId: json["course"]["assignment_id"],
    paperSetterName: RxString(json["course"]["paper_setter_name"]),
    paperSetters: List<PaperSetter>.from(json["paper_setters"].map((x) => PaperSetter.fromJson(x))),
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

class PaperSetter {
  final int id;
  final int user;
  final String name;
  final bool isExternal;
  final String gender;
  final DateTime dob;
  final String mobileNo;
  final String address;
  final String designation;
  final String qualification;
  final String bankAccountNo;
  final String bankIfsc;
  final String bankName;
  final String panNo;

  PaperSetter({
    required this.id,
    required this.user,
    required this.name,
    required this.isExternal,
    required this.gender,
    required this.dob,
    required this.mobileNo,
    required this.address,
    required this.designation,
    required this.qualification,
    required this.bankAccountNo,
    required this.bankIfsc,
    required this.bankName,
    required this.panNo,
  });

  factory PaperSetter.fromRawJson(String str) => PaperSetter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaperSetter.fromJson(Map<String, dynamic> json) => PaperSetter(
    id: json["id"],
    user: json["user"],
    name: json["name"],
    isExternal: json["is_external"],
    gender: json["gender"],
    dob: DateTime.parse(json["dob"]),
    mobileNo: json["mobile_no"],
    address: json["address"],
    designation: json["designation"],
    qualification: json["qualification"],
    bankAccountNo: json["bank_account_no"],
    bankIfsc: json["bank_ifsc"],
    bankName: json["bank_name"],
    panNo: json["pan_no"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "name": name,
    "is_external": isExternal,
    "gender": gender,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "mobile_no": mobileNo,
    "address": address,
    "designation": designation,
    "qualification": qualification,
    "bank_account_no": bankAccountNo,
    "bank_ifsc": bankIfsc,
    "bank_name": bankName,
    "pan_no": panNo,
  };
}
