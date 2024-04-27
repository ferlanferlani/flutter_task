import 'dart:convert';

class UpdateTaskRequestModel {
  final String title;
  final String description;

  UpdateTaskRequestModel({
    required this.title,
    required this.description,
  });

  factory UpdateTaskRequestModel.fromRawJson(String str) =>
      UpdateTaskRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateTaskRequestModel.fromJson(Map<String, dynamic> json) =>
      UpdateTaskRequestModel(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}
