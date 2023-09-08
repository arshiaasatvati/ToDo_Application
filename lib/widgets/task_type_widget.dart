import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../data/task_type.dart';

// ignore: must_be_immutable
class TaskTypeWidget extends StatefulWidget {
  TaskTypeWidget({
    super.key,
    required this.taskType,
    required this.index,
    required this.selectedType,
  });

  TaskType taskType;
  int index;
  int selectedType;

  @override
  State<TaskTypeWidget> createState() => _TaskTypeWidgetState();
}

class _TaskTypeWidgetState extends State<TaskTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                width: 2,
                color: widget.selectedType == widget.index ? kMainGreen : kGrey,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(widget.taskType.image),
                  Text(
                    widget.taskType.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
