import 'package:get/get.dart';
import 'login_controller.dart';
import '../../Data/Services/network_client.dart';
import '../../Data/utils/urls.dart';

class ProfileUpdateController extends GetxController{
  final LoginController loginController = Get.find<LoginController>();

  bool _isUpdateProfileInProgress = false;
  bool get isUpdateProfileInProgress => _isUpdateProfileInProgress;

  String? _errorMessage;
  String get errorMessage => _errorMessage ?? "";

  Future<bool> updateProfile(String email, String fName, String lName, String phone, String password) async {
    bool isSuccess = false;
    Map<String, dynamic> updateProfileRequestBody = {
      "email": email,
      "firstName": fName,
      "lastName": lName,
      "mobile": phone,
      "password": password,
    };

    _isUpdateProfileInProgress = true;
    update();
    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.updateProfileUrl,
      body: updateProfileRequestBody,
    );
    _isUpdateProfileInProgress = false;
    update();

    if (response.isSuccess) {
      await loginController.logIn(email, password);
      isSuccess = true;
      update();
      return isSuccess;
    }else{
      _errorMessage = response.errorMessage;
      return isSuccess;
    }
  }

}