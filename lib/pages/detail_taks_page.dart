// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_task/data_sources/task_remote_data_source.dart';
import 'package:flutter_task/models/get_task_response_model.dart';
import 'package:flutter_task/pages/home_page.dart';
import 'package:flutter_task/pages/update_task_page.dart';

import 'add_task_page.dart';

class DetailTaksPage extends StatefulWidget {
  final Task task;
  const DetailTaksPage({super.key, required this.task});

  @override
  State createState() => _DetailTaksPageState();
}

void showSuccessDeleteTask(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notification'),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                child: const Text('Ok'))
          ],
        );
      });
}

class _DetailTaksPageState extends State<DetailTaksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Task Detail',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text(widget.task.title),
                    subtitle: Text(widget.task.description),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              // confirmation button delete
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Confirmation'),
                                      content: const Text(
                                          'Are you sure to delete this task'),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('No')),
                                        TextButton(
                                            onPressed: () async {
                                              try {
                                                await TaskRemoteDataSource()
                                                    .deleteTask(widget.task.id);
                                                showSuccessDeleteTask(context,
                                                    'Task deleted successfully');
                                              } catch (e) {
                                                showDialog(
                                                    context: context,
                                                    builder: ((context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Notification'),
                                                        content: Text('$e'),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const HomePage()));
                                                              },
                                                              child: const Text(
                                                                  'Ok'))
                                                        ],
                                                      );
                                                    }));
                                              }
                                            },
                                            child: const Text('Yes')),
                                      ],
                                    );
                                  });
                            },
                            child: const Text('Delete')),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateTaskPage(task: widget.task)));
                            },
                            child: const Text('Update'))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
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
