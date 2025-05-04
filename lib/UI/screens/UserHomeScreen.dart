import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/Data/Services/network_client.dart';
import 'package:flutter_task_manager_api_project/UI/Controllers/task_count_controller.dart';
import 'package:flutter_task_manager_api_project/UI/screens/add_task.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/show_snakbar_message.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/summary_card.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_task_manager_api_project/Data/model/task_model.dart';
import '../../Data/utils/urls.dart';
import '../Controllers/cancel_task_fetch_controller.dart';
import '../Controllers/complete_task_fetch_controller.dart';
import '../Controllers/delete_task_controller.dart';
import '../Controllers/new_task_fetch_controller.dart';
import '../Controllers/progress_task_fetch_controller.dart';
import '../widgets/TMAppBar.dart';
import 'CancelTaskScreen.dart';
import 'CompletedTaskScreen.dart';
import 'NewTaskScreen.dart';
import 'ProgressTaskScreen.dart';

class UserHomeScreen extends StatefulWidget {
  UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int selectedIndex = 0;

  final GlobalKey<NewTaskScreenState> _newTaskKey = GlobalKey();
  final GlobalKey<ProgressTaskScreenState> _progressTaskKey = GlobalKey();
  final GlobalKey<CompletedTaskScreenState> _completedTaskKey = GlobalKey();
  final GlobalKey<CancelScreenState> _cancelTaskKey = GlobalKey();

  late NewTaskScreen _newTaskScreen;
  late ProgressTaskScreen _progressTaskScreen;
  late CompletedTaskScreen _completedTaskScreen;
  late CancelScreen _cancelScreen;

  final CancelTaskFetchController cancelTaskFetchController =
      Get.find<CancelTaskFetchController>();
  final NewTaskFetchController newTaskFetchController =
      Get.find<NewTaskFetchController>();
  final ProgressTaskFetchController progressTaskFetchController =
      Get.find<ProgressTaskFetchController>();
  final CompleteTaskFetchController completeTaskFetchController =
      Get.find<CompleteTaskFetchController>();

  final FetchTaskCountController taskCountController =
      Get.find<FetchTaskCountController>();

  final DeleteTaskController deleteTaskController = Get.find<DeleteTaskController>();

  Color getChipColor(String status) {
    if (status == "New") {
      return Colors.blue;
    } else if (status == "Complete") {
      return Colors.green;
    } else if (status == "Progress") {
      return Colors.purple;
    } else if (status == "Cancel") {
      return Colors.red;
    }
    return Colors.white;
  }

  void _refreshCurrentScreen() async {
    if (selectedIndex == 0) {
      newTaskFetchController.getNewTask();
    } else if (selectedIndex == 1) {
      progressTaskFetchController.getProgressTask();
    } else if (selectedIndex == 2) {
      completeTaskFetchController.getCompleteTask();
    } else if (selectedIndex == 3) {
      cancelTaskFetchController.getCancelTask();
    }
    await taskCountController.fetchTaskCount();
  }

  Future<void> deleteTask(TaskModel task) async{
    bool isSuccess = await deleteTaskController.deleteTask(task);
    if (isSuccess){
      showSnackBarMessage(context, 'Task deleted successfully.');
      taskCountController.fetchTaskCount();
      _refreshCurrentScreen();
    }else{
      showSnackBarMessage(context, deleteTaskController.errorMessage, true);
    }
  }

  @override
  void initState() {
    super.initState();

    _newTaskScreen = NewTaskScreen(
      key: _newTaskKey,
      getChipColor: getChipColor,
      deleteTask: deleteTask,
      taskCount: taskCountController.fetchTaskCount,
    );
    _progressTaskScreen = ProgressTaskScreen(
      key: _progressTaskKey,
      getChipColor: getChipColor,
      deleteTask: deleteTask,
      taskCount: taskCountController.fetchTaskCount,
    );
    _completedTaskScreen = CompletedTaskScreen(
      key: _completedTaskKey,
      getChipColor: getChipColor,
      deleteTask: deleteTask,
      taskCount: taskCountController.fetchTaskCount,
    );
    _cancelScreen = CancelScreen(
      key: _cancelTaskKey,
      getChipColor: getChipColor,
      deleteTask: deleteTask,
      taskCount: taskCountController.fetchTaskCount,
    );

    taskCountController.fetchTaskCount();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      _newTaskScreen,
      _progressTaskScreen,
      _completedTaskScreen,
      _cancelScreen,
    ];

    return Scaffold(
      appBar: TMAppBar(),
      body: Column(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
            scrollDirection: Axis.horizontal,
            child: GetBuilder(
              init: taskCountController,
              builder: (controller) {
                return Row(
                  spacing: 10.w,
                  children: [
                    GetBuilder(
                      init: taskCountController,
                      builder: (controller) {
                        return SummaryCard(
                          title: "New",
                          count: taskCountController.newCount,
                        );
                      },
                    ),
                    GetBuilder(
                      init: taskCountController,
                      builder: (controller) {
                        return SummaryCard(
                          title: "progressing",
                          count: taskCountController.progressCount,
                        );
                      },
                    ),
                    GetBuilder(
                      init: taskCountController,
                      builder: (controller) {
                        return SummaryCard(
                          title: "completed",
                          count: taskCountController.completeCount,
                        );
                      },
                    ),
                    GetBuilder(
                      init: taskCountController,
                      builder: (controller) {
                        return SummaryCard(
                          title: "canceled",
                          count: taskCountController.cancelCount,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(child: screens[selectedIndex]),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
          );
          if (result == true) {
            _refreshCurrentScreen();
          }
        },
        child: Icon(Icons.add),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (idx) {
          setState(() {
            selectedIndex = idx;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.new_label), label: 'New'),
          NavigationDestination(
            icon: Icon(Icons.ac_unit_sharp),
            label: 'Progress',
          ),
          NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
          NavigationDestination(icon: Icon(Icons.cancel), label: 'Canceled'),
        ],
      ),
    );
  }
}
