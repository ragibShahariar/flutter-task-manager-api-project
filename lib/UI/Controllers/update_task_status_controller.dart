import 'package:flutter_task_manager_api_project/Data/model/task_model.dart';
import 'package:get/get.dart';
import '../../Data/Services/network_client.dart';
import '../../Data/utils/urls.dart';

class UpdateTaskStatusController extends GetxController {
  bool _isTaskStatusUpdateInProgress = false;
  bool get isTaskStatusUpdateInProgress => _isTaskStatusUpdateInProgress;

  String? _errorMessage;
  String get errorMessage => _errorMessage ?? "";

  Future<bool> updateStatus(TaskModel task, String selectedStatus) async {
    bool _isSuccess = false;

    _isTaskStatusUpdateInProgress = true;
    update();

    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.updateTaskStatusUrl(task.id, selectedStatus),
    );

    _isTaskStatusUpdateInProgress = true;
    update();

    if (response.isSuccess) {
      _isSuccess = true;
      return _isSuccess;
    } else {
      _errorMessage = response.errorMessage;
      return _isSuccess;
    }
  }

}
