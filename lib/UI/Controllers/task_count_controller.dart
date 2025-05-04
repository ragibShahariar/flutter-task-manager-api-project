import 'package:get/get.dart';

import '../../Data/Services/network_client.dart';
import '../../Data/model/Task_Status_Count.dart';
import '../../Data/model/Task_Status_Count_List_Model.dart';
import '../../Data/utils/urls.dart';

class FetchTaskCountController extends GetxController {
  int _newCount = 0;
  int get newCount => _newCount;

  int _progressCount = 0;
  int get progressCount => _progressCount;

  int _completeCount = 0;
  int get completeCount => _completeCount;

  int _cancelCount = 0;
  int get cancelCount => _cancelCount;

  Future<void> fetchTaskCount() async {
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.getTaskStatusCountUrl,
    );

    if (response.isSuccess) {
      var taskCountList = TaskStatusCountListModel.fromJson(response.data!);

      _newCount = 0;
      _progressCount = 0;
      _completeCount = 0;
      _cancelCount = 0;

      for (TaskStatusCountModel taskCount in taskCountList.statusCountList) {
        switch (taskCount.status) {
          case "New":
            _newCount = taskCount.count;
            break;
          case "Progress":
            _progressCount = taskCount.count;
            break;
          case "Complete":
            _completeCount = taskCount.count;
            break;
          case "Cancel":
            _cancelCount = taskCount.count;
            break;
        }
      }

      update();
    }

  }
}
