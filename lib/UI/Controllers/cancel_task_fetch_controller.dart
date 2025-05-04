import 'package:flutter_task_manager_api_project/Data/model/Task_List_Model.dart';
import 'package:get/get.dart';
import '../../Data/Services/network_client.dart';
import '../../Data/model/task_model.dart';
import '../../Data/utils/urls.dart';

class CancelTaskFetchController extends GetxController {

  bool _isGetCancelTaskIsInProgress = false;
  bool get isGetNewTaskIsInProgress => _isGetCancelTaskIsInProgress;

  String? _errorMessage;
  String get errorMessage => _errorMessage ?? "" ;

  List<TaskModel> _cancelTasks = [];

  List<TaskModel> get cancelTasks => _cancelTasks;

  Future<bool> getCancelTask() async {
    bool isSuccess = false;
    _isGetCancelTaskIsInProgress = true;
    update();

    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.getCanceledTaskUrl,
    );

    _isGetCancelTaskIsInProgress = false;
    update();

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _cancelTasks = taskListModel.taskList;
      _errorMessage = null;
      isSuccess = true;
      return isSuccess;
    } else {
      _errorMessage = response.errorMessage;
    }
    return isSuccess;
  }
}
