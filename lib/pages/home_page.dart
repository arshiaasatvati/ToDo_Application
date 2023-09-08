import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/constants/colors.dart';
import 'package:note_application/pages/add_task_page.dart';
import 'package:note_application/widgets/task_widget.dart';

import '../data/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var taskBox = Hive.box<Task>('taskBox');
  bool isFabActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      floatingActionButton: _getFloatingActionButton(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ValueListenableBuilder(
            valueListenable: taskBox.listenable(),
            builder: (context, value, child) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  setState(() {
                    if (notification.direction == ScrollDirection.forward) {
                      isFabActive = true;
                    }
                    if (notification.direction == ScrollDirection.reverse) {
                      isFabActive = false;
                    }
                  });
                  return true;
                },
                child: ListView.builder(
                  itemCount: taskBox.values.length,
                  itemBuilder: (context, index) {
                    var task = taskBox.values.toList()[index];
                    print(task.taskType.title);
                    return _getTaskItem(task);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _getTaskItem(Task task) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        task.delete();
      },
      child: TaskWidget(task: task),
    );
  }

  Widget _getFloatingActionButton() {
    return Visibility(
      visible: isFabActive,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskPage(),
            ),
          );
        },
        child: Image.asset('images/icon_add.png'),
        backgroundColor: kMainGreen,
      ),
    );
  }
}
