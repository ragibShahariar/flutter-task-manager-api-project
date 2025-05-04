import 'package:get/get.dart';

import '../../Data/Services/network_client.dart';
import '../../Data/model/task_model.dart';
import '../../Data/utils/urls.dart';

class DeleteTaskController extends GetxController{
  bool _isTaskDeletionInProgress = false;
  bool get isTaskDeletionInProgress => _isTaskDeletionInProgress;

  String? _errorMessage;
  String get errorMessage => _errorMessage ?? "";

  Future<bool> deleteTask(TaskModel task) async {
    bool isSuccess = false;
    _isTaskDeletionInProgress = true;
    update();
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.deleteATaskUrl(task.id),
    );
    _isTaskDeletionInProgress = false;
    update();
    if (response.isSuccess) {
      isSuccess = true;
      return isSuccess;
    } else {
      _errorMessage = response.errorMessage;
      return isSuccess;
    }
  }
}