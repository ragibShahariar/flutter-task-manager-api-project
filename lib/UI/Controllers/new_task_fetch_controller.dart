import 'package:flutter_task_manager_api_project/Data/model/Task_List_Model.dart';
import 'package:get/get.dart';
import '../../Data/Services/network_client.dart';
import '../../Data/model/task_model.dart';
import '../../Data/utils/urls.dart';

class NewTaskFetchController extends GetxController {

  bool _isGetNewTaskIsInProgress = false;
  bool get isGetNewTaskIsInProgress => _isGetNewTaskIsInProgress;

  String? _errorMessage;
  String get errorMessage => _errorMessage ?? "" ;

  List<TaskModel> _newTasks = [];

  List<TaskModel> get newTasks => _newTasks;

  Future<bool> getNewTask() async {
    bool isSuccess = false;
    _isGetNewTaskIsInProgress = true;
    update();

    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.getNewTaskUrl,
    );

    _isGetNewTaskIsInProgress = false;
    update();

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _newTasks = taskListModel.taskList;
      _errorMessage = null;
      isSuccess = true;
      return isSuccess;
    } else {
      _errorMessage = response.errorMessage;
    }
    return isSuccess;
  }
}
