import 'package:flutter_task_manager_api_project/Data/model/Task_List_Model.dart';
import 'package:get/get.dart';
import '../../Data/Services/network_client.dart';
import '../../Data/model/task_model.dart';
import '../../Data/utils/urls.dart';

class CompleteTaskFetchController extends GetxController {

  bool _isGetCompleteTaskIsInProgress = false;
  bool get isGetNewTaskIsInProgress => _isGetCompleteTaskIsInProgress;

  String? _errorMessage;
  String get errorMessage => _errorMessage ?? "" ;

  List<TaskModel> _completeTasks = [];

  List<TaskModel> get completeTasks => _completeTasks;

  Future<bool> getCompleteTask() async {
    bool isSuccess = false;
    _isGetCompleteTaskIsInProgress = true;
    update();

    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.getCompletedTaskUrl,
    );

    _isGetCompleteTaskIsInProgress = false;
    update();

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _completeTasks = taskListModel.taskList;
      _errorMessage = null;
      isSuccess = true;
      return isSuccess;
    } else {
      _errorMessage = response.errorMessage;
    }
    return isSuccess;
  }
}
