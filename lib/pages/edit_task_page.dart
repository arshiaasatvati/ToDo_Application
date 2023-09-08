import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/constants/colors.dart';
import 'package:note_application/utilities/utility.dart';
import 'package:note_application/widgets/task_type_widget.dart';
import 'package:time_pickerr/time_pickerr.dart';

import '../data/task.dart';

// ignore: must_be_immutable
class EditTaskPage extends StatefulWidget {
  EditTaskPage({super.key, required this.task});

  Task task;

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  int _selectedType = 0;

  DateTime? _time;
  var box = Hive.box<Task>('taskBox');

  TextEditingController? controllerTitle;
  TextEditingController? controllerSubTitle;

  @override
  void initState() {
    super.initState();

    int index = taskTypeList.indexWhere(
      (element) => element.taskTypeEnum == widget.task.taskType.taskTypeEnum,
    );

    _selectedType = index;

    _time = widget.task.time;

    controllerTitle = TextEditingController(text: widget.task.title);
    controllerSubTitle = TextEditingController(text: widget.task.subTitle);

    focusNode1.addListener(() {
      setState(() {});
    });

    focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 42),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerTitle,
                    keyboardType: TextInputType.text,
                    focusNode: focusNode1,
                    cursorColor: kMainGreen,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      fontFamily: 'Shabnam',
                      color: kBlack,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                      labelText: 'عنوان تسک',
                      labelStyle: TextStyle(
                        fontFamily: 'Shabnam',
                        fontSize: 16,
                        color: focusNode1.hasFocus ? kMainGreen : kGrey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: kGrey, width: 2.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: kMainGreen, width: 2.5),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 42),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerSubTitle,
                    keyboardType: TextInputType.text,
                    focusNode: focusNode2,
                    cursorColor: kMainGreen,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Shabnam',
                      color: kBlack,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                      labelText: 'توضیحات تسک',
                      labelStyle: TextStyle(
                        fontFamily: 'Shabnam',
                        fontSize: 16,
                        color: focusNode2.hasFocus ? kMainGreen : kGrey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: kGrey, width: 2.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: kMainGreen, width: 2.5),
                      ),
                    ),
                  ),
                ),
              ),
              CustomHourPicker(
                title: 'انتخاب زمان',
                date: widget.task.time,
                titleStyle: TextStyle(
                  fontSize: 18,
                  color: kMainGreen,
                  fontWeight: FontWeight.w700,
                ),
                positiveButtonText: 'تایید',
                positiveButtonStyle: TextStyle(color: kMainGreen),
                elevation: 10,
                onPositivePressed: (context, time) {
                  _time = time;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: taskTypeList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedType = index;
                          });
                        },
                        child: TaskTypeWidget(
                          taskType: taskTypeList[index],
                          index: index,
                          selectedType: _selectedType,
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  String title = controllerTitle!.text;
                  String subTitle = controllerSubTitle!.text;
                  _editTask(title, subTitle);

                  Navigator.pop(context);
                },
                child: Text(
                  'ویرایش کردن تسک',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Shabnam',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kMainGreen,
                  minimumSize: Size(200, 50),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  _editTask(String title, String subTitle) {
    widget.task.title = title;
    widget.task.subTitle = subTitle;
    widget.task.time = _time!;
    widget.task.taskType = taskTypeList[_selectedType];
    widget.task.save();
  }
}
