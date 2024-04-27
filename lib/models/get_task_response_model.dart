import 'dart:convert';

class TasksResponseModel {
  final bool success;
  final String message;
  final List<Task> data;

  TasksResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory TasksResponseModel.fromRawJson(String str) =>
      TasksResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TasksResponseModel.fromJson(Map<String, dynamic> json) =>
      TasksResponseModel(
        success: json["success"] ?? false,
        message: json["message"],
        data: json["data"] != null
            ? List<Task>.from(json["data"].map((x) => Task.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory Task.fromRawJson(String str) => Task.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Task.fromJson(Map<String, dynamic> json) => Task(
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
