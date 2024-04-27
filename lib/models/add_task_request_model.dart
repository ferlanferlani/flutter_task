import 'dart:convert';

class AddTaskRequestModel {
  final String title;
  final String description;

  AddTaskRequestModel({
    required this.title,
    required this.description,
  });

  factory AddTaskRequestModel.fromRawJson(String str) =>
      AddTaskRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddTaskRequestModel.fromJson(Map<String, dynamic> json) =>
      AddTaskRequestModel(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}
