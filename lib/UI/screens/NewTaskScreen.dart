import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/Data/Services/network_client.dart';
import 'package:flutter_task_manager_api_project/Data/model/Task_List_Model.dart';
import 'package:flutter_task_manager_api_project/Data/utils/urls.dart';
import 'package:flutter_task_manager_api_project/UI/Controllers/new_task_fetch_controller.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/CenterCircullarProgressIndicator.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/TaskCard.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/show_snakbar_message.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Data/model/task_model.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({
    super.key,
    required this.deleteTask,
    required this.getChipColor,
    required this.taskCount,
  });

  final Future<void> Function(TaskModel task, ) deleteTask;
  final Color Function(String status) getChipColor;
  final Future<void> Function() taskCount;

  @override
  State<NewTaskScreen> createState() => NewTaskScreenState();
}

class NewTaskScreenState extends State<NewTaskScreen> {
  final NewTaskFetchController newTaskFetchController =
      Get.find<NewTaskFetchController>();

  @override
  void initState() {
    newTaskFetchController.getNewTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    GetBuilder(
      init: newTaskFetchController,
      builder: (controller) {
        return Visibility(
          replacement: CenterCircularProgressIndicator(),
          visible: !newTaskFetchController.isGetNewTaskIsInProgress,
          child: ListView.separated(
            itemCount: controller.newTasks.length,
            itemBuilder: (context, index) {
              return TaskCard(
                task: controller.newTasks[index],
                getChipColor: widget.getChipColor,
                deleteTask: widget.deleteTask,
                getTask: newTaskFetchController.getNewTask,
                fetchTaskCount: widget.taskCount,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 5),
          ),
        );
      },
    );
  }
}
