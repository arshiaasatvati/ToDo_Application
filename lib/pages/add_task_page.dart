import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/constants/colors.dart';
import 'package:note_application/utilities/utility.dart';
import 'package:note_application/widgets/task_type_widget.dart';
import 'package:time_pickerr/time_pickerr.dart';

import '../data/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  var box = Hive.box<Task>('taskBox');

  DateTime? _time;
  int _selectedType = 0;

  var controllerTitle = TextEditingController();
  var controllerSubTitle = TextEditingController();

  @override
  void initState() {
    super.initState();
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
              SizedBox(height: 8),
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
                  String title = controllerTitle.text;
                  String subTitle = controllerSubTitle.text;
                  _addTask(title, subTitle);

                  Navigator.pop(context);
                },
                child: Text(
                  'اضافه کردن تسک',
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

  _addTask(String title, String subTitle) {
    var task = Task(
        title: title,
        subTitle: subTitle,
        time: _time!,
        taskType: taskTypeList[_selectedType]);
    box.add(task);
  }
}
