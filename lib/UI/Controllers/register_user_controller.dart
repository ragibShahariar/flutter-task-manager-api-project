import 'package:get/get.dart';

import '../../Data/Services/network_client.dart';
import '../../Data/utils/urls.dart';

class RegisterUserController extends GetxController{
  bool _isRegistrationInProgress = false;
  bool get isRegistrationInProgress => _isRegistrationInProgress;

  String? _errorMessage;
  String get errorMessage => _errorMessage ?? "";

  Future<bool> registerUser(String email, String fName, String lName, String phone, String password) async {
    _isRegistrationInProgress = true;
    update();

    bool _isSuccess = false;

    Map<String, dynamic> requestBody = {
      "email": email.trim(),
      "firstName": fName.trim(),
      "lastName": lName.trim(),
      "mobile": phone.trim(),
      "password": password,
    };

    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.registerUrl,
      body: requestBody,
    );

    _isRegistrationInProgress = false;
    update();

    if (response.isSuccess){
      _errorMessage = null;
      _isSuccess = true;
      return _isSuccess;
    }else{
      return _isSuccess;
    }
  }
}