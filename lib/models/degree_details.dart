import 'dart:convert';

class DegreesDetail {
  final List<Degree> degrees;

  DegreesDetail({
    required this.degrees,
  });

  factory DegreesDetail.fromRawJson(String str) => DegreesDetail.fromJson(json.decode(str));

  factory DegreesDetail.fromJson(Map<String, dynamic> json) => DegreesDetail(
    degrees: List<Degree>.from(json["degrees"].map((x) => Degree.fromJson(x))),
  );

}

class Degree {
  final String name;
  final List<Scheme> schemes;

  Degree({
    required this.schemes,
    required this.name
  });

  factory Degree.fromRawJson(String str) => Degree.fromJson(json.decode(str));

  factory Degree.fromJson(Map<String, dynamic> json) => Degree(
    name: json.keys.first,
    schemes: List<Scheme>.from(json[json.keys.first].map((x) => Scheme.fromJson(x))),
  );

}

class Scheme {
  final int year;
  final int id;

  Scheme({
    required this.year,
    required this.id,
  });

  factory Scheme.fromRawJson(String str) => Scheme.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Scheme.fromJson(Map<String, dynamic> json) => Scheme(
    year: json["year"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "id": id,
  };
}