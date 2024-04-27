import 'package:flutter/material.dart';
import 'package:flutter_task/data_sources/task_remote_data_source.dart';
import 'package:flutter_task/pages/add_task_page.dart';
import 'package:flutter_task/pages/detail_taks_page.dart';

import '../models/get_task_response_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  List<Task> tasks = [];

  Future<void> getTasks() async {
    setState(() {
      isLoading = true;
    });
    final taskModel = await TaskRemoteDataSource().getTasks();
    tasks = taskModel.data;

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlue,
        title: Padding(
          padding: const EdgeInsets.only(
            right: 8,
            left: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Task List',
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Me',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : tasks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/nodata.png',
                        height: 190,
                      ),
                      const Text('no data.')
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Card(
                              child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailTaksPage(
                                            task: tasks[index],
                                          )));
                            },
                            child: ListTile(
                              leading: const Icon(Icons.task_alt_sharp),
                              title: Text(tasks[index].title),
                              subtitle: Text(tasks[index].createdAt.toString()),
                            ),
                          ))
                        ],
                      ),
                    );
                  }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskPage()),
          );
          getTasks();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
