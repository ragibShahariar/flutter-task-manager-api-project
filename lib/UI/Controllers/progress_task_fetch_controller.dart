import 'package:flutter_task_manager_api_project/Data/model/Task_List_Model.dart';
import 'package:get/get.dart';
import '../../Data/Services/network_client.dart';
import '../../Data/model/task_model.dart';
import '../../Data/utils/urls.dart';

class ProgressTaskFetchController extends GetxController {

  bool _isGetProgressTaskIsInProgress = false;
  bool get isGetNewTaskIsInProgress => _isGetProgressTaskIsInProgress;

  String? _errorMessage;
  String get errorMessage => _errorMessage ?? "" ;

  List<TaskModel> _progressTasks = [];

  List<TaskModel> get progressTask => _progressTasks;

  Future<bool> getProgressTask() async {
    bool isSuccess = false;
    _isGetProgressTaskIsInProgress = true;
    update();

    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.getProgressTaskUrl,
    );

    _isGetProgressTaskIsInProgress = false;
    update();

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _progressTasks = taskListModel.taskList;
      _errorMessage = null;
      isSuccess = true;
      return isSuccess;
    } else {
      _errorMessage = response.errorMessage;
    }
    return isSuccess;
  }
}
