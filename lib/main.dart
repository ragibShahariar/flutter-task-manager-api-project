import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/app.dart';
//
//Assalamualikum vai. Sometimes the project shows distorted logo in splash screen sometimes id does not
//Also after login it shows error about cancel controller. but if i Rerun the project it vanishes.
//I don't know if its happening only on my mac or other devices also.
//
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return TaskManagerApp();
  }
}
