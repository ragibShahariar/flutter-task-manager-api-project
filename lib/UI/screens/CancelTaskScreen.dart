import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/Data/Services/network_client.dart';
import 'package:flutter_task_manager_api_project/Data/model/Task_List_Model.dart';
import 'package:flutter_task_manager_api_project/Data/utils/urls.dart';
import 'package:flutter_task_manager_api_project/UI/Controllers/cancel_task_fetch_controller.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/CenterCircullarProgressIndicator.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/TaskCard.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/show_snakbar_message.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Data/model/task_model.dart';

class CancelScreen extends StatefulWidget {
  const CancelScreen({
    super.key,
    required this.deleteTask,
    required this.getChipColor,
    required this.taskCount,
  });

  final Future<void> Function(TaskModel task) deleteTask;
  final Color Function(String status) getChipColor;
  final Future<void> Function() taskCount;

  @override
  State<CancelScreen> createState() => CancelScreenState();
}

class CancelScreenState extends State<CancelScreen> {
  final CancelTaskFetchController cancelTaskFetchController = Get.find<CancelTaskFetchController>();

  @override
  void initState() {
    cancelTaskFetchController.getCancelTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder(
      init: cancelTaskFetchController,
      builder: (controller){
        return Visibility(
          replacement: CenterCircularProgressIndicator(),
          visible: !cancelTaskFetchController.isGetNewTaskIsInProgress,
          child: ListView.separated(
            itemCount: controller.cancelTasks.length,
            itemBuilder: (context, index) {
              return TaskCard(
                task: controller.cancelTasks[index],
                getChipColor: widget.getChipColor,
                deleteTask: widget.deleteTask,
                getTask: cancelTaskFetchController.getCancelTask,
                fetchTaskCount: widget.taskCount,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 5),
          ),
        );
      }
    );
  }
}
