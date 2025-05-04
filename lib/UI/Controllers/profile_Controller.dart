import 'package:flutter_task_manager_api_project/UI/Controllers/auth_controller.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  String fullName = AuthController.userModel!.fullName;
  String firstName = AuthController.userModel!.firstName;
  String lastName = AuthController.userModel!.lastName;
  String phoneNumber = AuthController.userModel!.mobile;
  String userEmail = AuthController.userModel!.email;

  void refreshFromAuth() {
    fullName = AuthController.userModel!.fullName;
    firstName = AuthController.userModel!.firstName;
    lastName = AuthController.userModel!.lastName;
    phoneNumber = AuthController.userModel!.mobile;
    userEmail = AuthController.userModel!.email;
    update();
  }

}