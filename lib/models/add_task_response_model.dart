import 'dart:convert';

class AddTaskResponseModel {
  final bool success;
  final String message;
  final Data data;

  AddTaskResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AddTaskResponseModel.fromRawJson(String str) =>
      AddTaskResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddTaskResponseModel.fromJson(Map<String, dynamic> json) =>
      AddTaskResponseModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;

  Data({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
      };
}
