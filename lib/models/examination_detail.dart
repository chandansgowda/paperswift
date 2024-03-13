import 'dart:convert';

class ExaminationDetail {
  final List<Department> departments;
  final int count;
  final int assignmentStatus;

  ExaminationDetail({
    required this.departments,
    required this.count,
    required this.assignmentStatus,
  });

  factory ExaminationDetail.fromRawJson(String str) => ExaminationDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExaminationDetail.fromJson(Map<String, dynamic> json) => ExaminationDetail(
    departments: List<Department>.from(json["departments"].map((x) => Department.fromJson(x))),
    count: json["count"],
    assignmentStatus: json["assignment_status"],
  );

  Map<String, dynamic> toJson() => {
    "departments": List<dynamic>.from(departments.map((x) => x.toJson())),
    "count": count,
    "assignment_status": assignmentStatus,
  };
}

class Department {
  final String name;
  final List<PaperSetter> paperSetters;
  final List<Course> courses;

  Department({
    required this.paperSetters,
    required this.courses,
    required this.name,
  });

  factory Department.fromRawJson(String str) => Department.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    name: json.keys.first,
    paperSetters: List<PaperSetter>.from(json[json.keys.first]["paper_setters"].map((x) => PaperSetter.fromJson(x))),
    courses: List<Course>.from(json[json.keys.first]["courses"].map((x) => Course.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "paper_setters": List<dynamic>.from(paperSetters.map((x) => x.toJson())),
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
  String paperSetterName="";
  int paperSetterId=0;

  Course({
    required this.code,
    required this.name,
    required this.scheme,
    required this.syllabusDocUrl,
    required this.department,
    required this.sem,
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
