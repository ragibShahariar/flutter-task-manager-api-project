import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/Data/Services/network_client.dart';
import 'package:flutter_task_manager_api_project/Data/model/Task_List_Model.dart';
import 'package:flutter_task_manager_api_project/Data/utils/urls.dart';
import 'package:flutter_task_manager_api_project/UI/Controllers/progress_task_fetch_controller.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/CenterCircullarProgressIndicator.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/TaskCard.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/show_snakbar_message.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Data/model/task_model.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({
    super.key,
    required this.deleteTask,
    required this.getChipColor,
    required this.taskCount,
  });

  final Future<void> Function(TaskModel task) deleteTask;
  final Color Function(String status) getChipColor;
  final Future<void> Function() taskCount;

  @override
  State<ProgressTaskScreen> createState() => ProgressTaskScreenState();
}

class ProgressTaskScreenState extends State<ProgressTaskScreen> {
  final ProgressTaskFetchController progressTaskFetchController =
      Get.find<ProgressTaskFetchController>();

  @override
  void initState() {
    progressTaskFetchController.getProgressTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    GetBuilder(
      init: progressTaskFetchController,
      builder: (controller) {
        return Visibility(
          replacement: CenterCircularProgressIndicator(),
          visible: !progressTaskFetchController.isGetNewTaskIsInProgress,
          child: ListView.separated(
            itemCount: controller.progressTask.length,
            itemBuilder: (context, index) {
              return TaskCard(
                task: controller.progressTask[index],
                getChipColor: widget.getChipColor,
                deleteTask: widget.deleteTask,
                getTask: progressTaskFetchController.getProgressTask,
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
