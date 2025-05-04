import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/Data/Services/network_client.dart';
import 'package:flutter_task_manager_api_project/Data/model/Task_List_Model.dart';
import 'package:flutter_task_manager_api_project/Data/utils/urls.dart';
import 'package:flutter_task_manager_api_project/UI/Controllers/complete_task_fetch_controller.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/CenterCircullarProgressIndicator.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/TaskCard.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/show_snakbar_message.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Data/model/task_model.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({
    super.key,
    required this.deleteTask,
    required this.getChipColor,
    required this.taskCount,
  });

  final Future<void> Function(TaskModel task) deleteTask;
  final Color Function(String status) getChipColor;
  final Future<void> Function() taskCount;

  @override
  State<CompletedTaskScreen> createState() => CompletedTaskScreenState();
}

class CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final CompleteTaskFetchController completeTaskFetchController =
      Get.find<CompleteTaskFetchController>();

  @override
  void initState() {
    completeTaskFetchController.getCompleteTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: completeTaskFetchController,
      builder: (controller) {
        return Visibility(
          replacement: CenterCircularProgressIndicator(),
          visible: !completeTaskFetchController.isGetNewTaskIsInProgress,
          child: ListView.separated(
            itemCount: controller.completeTasks.length,
            itemBuilder: (context, index) {
              return TaskCard(
                task: controller.completeTasks[index],
                getChipColor: widget.getChipColor,
                deleteTask: widget.deleteTask,
                getTask: completeTaskFetchController.getCompleteTask,
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
