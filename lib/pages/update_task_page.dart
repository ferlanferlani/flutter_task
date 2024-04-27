// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_task/data_sources/task_remote_data_source.dart';
import 'package:flutter_task/models/update_task_request_model.dart';
import 'package:flutter_task/pages/home_page.dart';

import '../models/get_task_response_model.dart';
import 'add_task_page.dart';

class UpdateTaskPage extends StatefulWidget {
  final Task task;
  const UpdateTaskPage({super.key, required this.task});

  @override
  State createState() => _UpdateTaskPage();
}

class _UpdateTaskPage extends State<UpdateTaskPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.description;
    super.initState();
  }

  void showSucessUpdateDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notification'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Update Task',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Expanded(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Title'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Description'),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final data = UpdateTaskRequestModel(
                        title: titleController.text,
                        description: descriptionController.text,
                      );

                      await TaskRemoteDataSource()
                          .updateTask(widget.task.id, data);
                      showSucessUpdateDialog(
                          context, 'Task successfully updated.');
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Error'),
                          content: Text('$e'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 50),
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
              ],
            )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTaskPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
