import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/Data/Services/network_client.dart';
import 'package:flutter_task_manager_api_project/Data/model/profile_update_model.dart';
import 'package:flutter_task_manager_api_project/Data/utils/urls.dart';
import 'package:flutter_task_manager_api_project/UI/Controllers/auth_controller.dart';
import 'package:flutter_task_manager_api_project/UI/Controllers/profile_update_controller.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/backgroundSVG.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/show_snakbar_message.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../../Data/model/login_model.dart';
import '../../ui/screens/log_in_screen.dart';
import '../Controllers/profile_Controller.dart';
import '../widgets/CenterCircullarProgressIndicator.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _updateEmailController = TextEditingController(
    text: AuthController.userModel?.email ?? "",
  );
  final TextEditingController _updateFNameController = TextEditingController(
    text: AuthController.userModel?.firstName ?? "",
  );
  final TextEditingController _updateLNameController = TextEditingController(
    text: AuthController.userModel?.lastName ?? "",
  );
  final TextEditingController _updatePhoneController = TextEditingController(
    text: AuthController.userModel?.mobile ?? "",
  );
  final TextEditingController _updatePasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ProfileUpdateController profileUpdateController =
      Get.find<ProfileUpdateController>();

  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundSvg(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.green),
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  "https://avatars.githubusercontent.com/u/132939355?v=4",
                ),
              ),
              Text(
                'Update Profile',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Color(0xff5DB161), Color(0xffB5ECD0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    spacing: 10,
                    children: [
                      TextFormField(
                        controller: _updateEmailController,
                        readOnly: true, // Make email read-only
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: "Email",
                        ),
                      ),
                      TextFormField(
                        controller: _updateFNameController,
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter your first name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _updateLNameController,
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter your last name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _updatePhoneController,
                        validator: (String? value) {
                          String phone = value?.trim() ?? '';
                          RegExp regExp = RegExp(
                            r"^(?:\+?88|0088)?01[15-9]\d{8}$",
                          );
                          if (regExp.hasMatch(phone) == false) {
                            return 'Enter your valid phone';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _updatePasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: "Enter new password",
                        ),
                        validator: (String? value) {
                          if ((value?.isEmpty ?? true) || (value!.length < 6)) {
                            return 'Enter your password more than 6 letters';
                          }
                          return null;
                        },
                      ),
                      GetBuilder(
                        init: profileUpdateController,
                        builder: (controller) {
                          return Visibility(
                            visible:
                                !profileUpdateController
                                    .isUpdateProfileInProgress,
                            replacement:
                                const CenterCircularProgressIndicator(),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _onTapSubmitButton,
                                child: Icon(
                                  Icons.double_arrow_sharp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _updateProfile();
    }
  }

  void _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      bool isSuccess = await profileUpdateController.updateProfile(
        _updateEmailController.text.trim(),
        _updateFNameController.text.trim(),
        _updateLNameController.text.trim(),
        _updatePhoneController.text.trim(),
        _updatePasswordController.text.trim(),
      );
      if (isSuccess) {
        showSnackBarMessage(context, 'User updated successfully!');
        profileController.refreshFromAuth();
        Get.back();
      } else {
        showSnackBarMessage(
          context,
          profileUpdateController.errorMessage,
          true,
        );
      }
    }
  }

  @override
  void dispose() {
    _updateEmailController.dispose();
    _updateFNameController.dispose();
    _updateLNameController.dispose();
    _updatePasswordController.dispose();
    _updatePhoneController.dispose();
    super.dispose();
  }
}
