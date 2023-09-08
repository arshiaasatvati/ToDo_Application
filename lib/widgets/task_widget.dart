import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:note_application/pages/edit_task_page.dart';

import '../constants/colors.dart';
import '../data/task.dart';

// ignore: must_be_immutable
class TaskWidget extends StatefulWidget {
  TaskWidget({super.key, required this.task});

  Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;

  @override
  void initState() {
    isBoxChecked = widget.task.isDone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getTaskContainer();
  }

  Widget _getTaskContainer() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBoxChecked = !isBoxChecked;
          widget.task.isDone = isBoxChecked;
          widget.task.save();
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        height: 132,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: _getMainContent(),
        ),
      ),
    );
  }

  Widget _getMainContent() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          Image.asset(widget.task.taskType.image),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Row(
                    children: [
                      _getTitlesColumn(),
                      Spacer(),
                      _getCheckBox(),
                    ],
                  ),
                ),
                Spacer(),
                _getBadges(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBadges() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskPage(
                    task: widget.task,
                  ),
                ),
              );
            },
            child: Container(
              width: 100,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: kLightGreen,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        'images/icon_edit.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'ویرایش',
                      style: TextStyle(
                        color: kMainGreen,
                        fontSize: 16,
                        fontFamily: 'Shabnam',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 4),
          Container(
            width: 100,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: kMainGreen,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    child: Image.asset(
                      'images/icon_time.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    '${_getFixedHour(widget.task.time)} : ${_getFixedMinute(widget.task.time)}',
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 16,
                      fontFamily: 'Shabnam',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCheckBox() {
    return MSHCheckbox(
      size: 28,
      value: isBoxChecked,
      colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
        checkedColor: kMainGreen,
      ),
      style: MSHCheckboxStyle.fillScaleColor,
      onChanged: (selected) {
        setState(() {
          isBoxChecked = selected;
        });
      },
    );
  }

  Widget _getTitlesColumn() {
    return Container(
      width: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.task.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Shabnam',
                fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 8),
          Text(
            widget.task.subTitle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Shabnam',
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  String _getFixedHour(DateTime time) {
    if (time.hour < 10) {
      return '0${time.hour}';
    } else {
      return time.hour.toString();
    }
  }

  String _getFixedMinute(DateTime time) {
    if (time.minute < 10) {
      return '0${time.minute}';
    } else {
      return time.minute.toString();
    }
  }
}
