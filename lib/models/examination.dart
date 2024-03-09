import 'dart:convert';

class Examination {
  final int eid;
  final int sem;
  final bool isSupplementary;
  final DateTime paperSubmissionDeadline;
  final bool isExamCompleted;
  final String description;
  final String degree;
  final int scheme;

  Examination({
    required this.eid,
    required this.sem,
    required this.isSupplementary,
    required this.paperSubmissionDeadline,
    required this.isExamCompleted,
    required this.description,
    required this.degree,
    required this.scheme,
  });

  factory Examination.fromRawJson(String str) => Examination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Examination.fromJson(Map<String, dynamic> json) => Examination(
    eid: json["eid"],
    sem: json["sem"],
    isSupplementary: json["is_supplementary"],
    paperSubmissionDeadline: DateTime.parse(json["paper_submission_deadline"]),
    isExamCompleted: json["is_exam_completed"],
    description: json["description"],
    degree: json["degree"],
    scheme: json["scheme"],
  );

  Map<String, dynamic> toJson() => {
    "eid": eid,
    "sem": sem,
    "is_supplementary": isSupplementary,
    "paper_submission_deadline": "${paperSubmissionDeadline.year.toString().padLeft(4, '0')}-${paperSubmissionDeadline.month.toString().padLeft(2, '0')}-${paperSubmissionDeadline.day.toString().padLeft(2, '0')}",
    "is_exam_completed": isExamCompleted,
    "description": description,
    "degree": degree,
    "scheme": scheme,
  };
}
