import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/UI/Controllers/login_controller.dart';
import 'package:flutter_task_manager_api_project/UI/screens/RegisterScreen.dart';
import 'package:flutter_task_manager_api_project/UI/screens/UserHomeScreen.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/CenterCircullarProgressIndicator.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/backgroundSVG.dart';
import 'package:flutter_task_manager_api_project/UI/screens/ForgetPasswordEmailScreen.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/show_snakbar_message.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundSvg(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(2.w),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 2.h,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 1.h,
                  children: [
                    Text(
                      'Get Started With',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Enter credential to Sign in',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                TextFormField(
                  controller: _emailTEController,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return 'Enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordTEController,
                  decoration: InputDecoration(hintText: 'Password'),                  validator: (value){
                  if (value == null || value.isEmpty){
                    return 'Enter password to login';
                  }
                  return null;
                },
                ),
                GetBuilder(
                  init: loginController,
                  builder: (controller){
                    return Visibility(
                      replacement: CenterCircularProgressIndicator(),
                      visible: !loginController.loginProgress,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _onTapSignInButton,
                          child: Icon(Icons.double_arrow_outlined),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 5.h),
                Column(
                  children: [
                    Center(
                      child: TextButton(
                        onPressed: _onTapForgotPasswordButton,
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have account?"),
                        TextButton(
                          onPressed: _onTapSignUpButton,
                          child: Text(
                            "Sign up",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignInButton() async{
    if (_formKey.currentState!.validate()){
      bool isSuccessful = await loginController.logIn(_emailTEController.text, _passwordTEController.text);
      if (isSuccessful){
        showSnackBarMessage(context, "Login Successful.");
        Get.offAll(UserHomeScreen());
      }else{
        showSnackBarMessage(context, loginController.errorMessage);
      }
    }
  }

  void _onTapForgotPasswordButton() {
    Get.to(ForgetPasswordEmailScreen());
  }

  void _onTapSignUpButton() {
    Get.to(RegisterScreen());
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }

}
