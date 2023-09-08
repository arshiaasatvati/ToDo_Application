import '../data/task_type.dart';
import '../data/task_type_enum.dart';

List<TaskType> taskTypeList = [
  TaskType(
    image: 'images/hard_working.png',
    title: 'کار زیاد',
    taskTypeEnum: TaskTypeEnum.working,
  ),
  TaskType(
    image: 'images/meditate.png',
    title: 'تمرکز',
    taskTypeEnum: TaskTypeEnum.meditation,
  ),
  TaskType(
    image: 'images/work_meeting.png',
    title: 'قرار',
    taskTypeEnum: TaskTypeEnum.date,
  ),
  TaskType(
    image: 'images/social_friends.png',
    title: 'میتینگ',
    taskTypeEnum: TaskTypeEnum.meeting,
  ),
  TaskType(
    image: 'images/workout.png',
    title: 'ورزش',
    taskTypeEnum: TaskTypeEnum.workout,
  ),
];
