import 'package:flutter_task_manager_api_project/UI/Controllers/new_task_fetch_controller.dart';
import 'package:flutter_task_manager_api_project/UI/Controllers/register_user_controller.dart';
import 'package:flutter_task_manager_api_project/UI/Controllers/task_count_controller.dart';
import 'package:get/get.dart';
import 'UI/Controllers/cancel_task_fetch_controller.dart';
import 'UI/Controllers/complete_task_fetch_controller.dart';
import 'UI/Controllers/delete_task_controller.dart';
import 'UI/Controllers/login_controller.dart';
import 'UI/Controllers/profile_Controller.dart';
import 'UI/Controllers/profile_update_controller.dart';
import 'UI/Controllers/progress_task_fetch_controller.dart';
import 'UI/Controllers/update_task_status_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.lazyPut(() => NewTaskFetchController());
    Get.lazyPut(() => ProgressTaskFetchController());
    Get.lazyPut(() => CancelTaskFetchController());
    Get.lazyPut(() => CompleteTaskFetchController());
    Get.lazyPut(() => RegisterUserController());
    Get.lazyPut(() => FetchTaskCountController());
    Get.lazyPut(() => DeleteTaskController());
    Get.lazyPut(() => UpdateTaskStatusController());
    Get.lazyPut(() => ProfileUpdateController());
    Get.lazyPut(() => ProfileController());
  }
}