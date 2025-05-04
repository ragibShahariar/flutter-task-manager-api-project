import 'package:get/get.dart';

import '../../Data/Services/network_client.dart';
import '../../Data/model/login_model.dart';
import '../../Data/utils/urls.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  bool _loginInProgress = false;
  bool get loginProgress => _loginInProgress;

  String? _errorMessage;
  String get errorMessage => _errorMessage!;

  Future<bool> logIn(String email, String password) async {
    bool _isSuccess = false;
    _loginInProgress = true;
    update();

    Map<String, dynamic> requestBody = {"email": email, "password": password};

    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.loginUrl,
      body: requestBody,
    );
    _loginInProgress = false;
    update();

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJason(response.data!);
      await AuthController.saveUserInformation(
        loginModel.token,
        loginModel.userModel,
      );
      _isSuccess = true;
      return _isSuccess;
    } else {
      _errorMessage = response.errorMessage!;
    }
    return _isSuccess;
  }
}
