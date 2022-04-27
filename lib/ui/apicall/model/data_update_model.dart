// To parse this JSON data, do
//
//     final dataUpdateModel = dataUpdateModelFromJson(jsonString);

import 'dart:convert';

DataUpdateModel dataUpdateModelFromJson(String str) => DataUpdateModel.fromJson(json.decode(str));

String dataUpdateModelToJson(DataUpdateModel data) => json.encode(data.toJson());

class DataUpdateModel {
  DataUpdateModel({
    required this.name,
    required this.job,
    required this.updatedAt,
  });

  String name;
  String job;
  DateTime updatedAt;

  factory DataUpdateModel.fromJson(Map<String, dynamic> json) => DataUpdateModel(
    name: json["name"],
    job: json["job"],
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "job": job,
    "updatedAt": updatedAt.toIso8601String(),
  };
}
