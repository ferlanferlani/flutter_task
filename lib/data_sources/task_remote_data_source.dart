import 'dart:convert';

import 'package:flutter_task/models/add_task_request_model.dart';
import 'package:flutter_task/models/add_task_response_model.dart';
import 'package:flutter_task/models/get_task_response_model.dart';
import 'package:flutter_task/models/update_task_request_model.dart';
import 'package:flutter_task/models/update_task_response_model.dart';

import 'package:http/http.dart' as http;

class TaskRemoteDataSource {
  final endpoint = 'https://flutter-tasks-api.vercel.app/tasks/';

  // get all tasks
  Future<TasksResponseModel> getTasks() async {
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      return TasksResponseModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  // create task
  Future<AddTaskResponseModel> addTask(AddTaskRequestModel data) async {
    final response = await http.post(Uri.parse(endpoint),
        body: jsonEncode(data),
        headers: <String, String>{'Content-Type': 'application/json'});

    if (response.statusCode == 201) {
      return AddTaskResponseModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed create task!');
    }
  }

  // delete task
  Future<AddTaskResponseModel> deleteTask(String id) async {
    final response = await http.delete(Uri.parse(endpoint + (id)));
    if (response.statusCode == 200) {
      return AddTaskResponseModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to delete task!');
    }
  }

  Future<UpdateTaskReponseModel> updateTask(
      String id, UpdateTaskRequestModel data) async {
    final response = await http.put(Uri.parse(endpoint + id),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return UpdateTaskReponseModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception(
          'Failed to update task! Status code: ${response.statusCode}');
    }
  }
}
