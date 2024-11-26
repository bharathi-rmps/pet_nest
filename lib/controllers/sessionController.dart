import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet_nest/screens/auth/loginUser.dart';
import 'package:pet_nest/utils/apiEndpoint.dart';
import 'package:http/http.dart' as http;

class sessionController extends GetxController {
  // Reactive session state
  var isLoggedIn = false.obs;
  var id = 0.obs;
  var username = ''.obs;
  var firstname = ''.obs;
  var lastname = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var phone = ''.obs;
  var userStatus = 0.obs;

  // Storage instance for persisting session
  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // check persisted session status
    isLoggedIn.value = _storage.read('isLoggedIn') ?? false;
    id.value = _storage.read('id') ?? 0;
    username.value = _storage.read('username') ?? '';
    firstname.value = _storage.read('firstname') ?? '';
    lastname.value = _storage.read('lastname') ?? '';
    email.value = _storage.read('email') ?? '';
    password.value = _storage.read('password') ?? '';
    phone.value = _storage.read('phone') ?? '';
    userStatus.value = _storage.read('userStatus') ?? 0;
  }

  // set session
  int createSession(String userName) {
    isLoggedIn.value = true;
    username.value = userName;
    _storage.write('isLoggedIn', true);
    getUserDetails(userName);
    return 0;
  }

  // clear session
  void logout() {
    isLoggedIn.value = false;
    id.value = 0;
    username.value = '';
    firstname.value = '';
    lastname.value = '';
    email.value = '';
    password.value = '';
    phone.value = '';
    userStatus.value = 0;
    _storage.erase();
    Get.off(() => loginUserScreen());
  }

  // get user details from API
  Future<void> getUserDetails(String userName) async {
    var url = Uri.parse(
        apiEndpoint.baseUrl + apiEndpoint.userEndpoints.getUserDetails + userName);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        //print("data: $data");

        // extract and store details
        id.value = data['id'] ?? 0;
        firstname.value = data['firstName'] ?? '';
        lastname.value = data['lastName'] ?? '';
        email.value = data['email'] ?? '';
        password.value = data['password'] ?? '';
        phone.value = data['phone']?.toString() ?? '';
        userStatus.value = data['userStatus'] ?? 0;

        // persist in storage with correct types
        saveSessionToStorage();

      } else {
        Get.snackbar(
          "Error",
          "Error Details",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.primaryColorLight,
        );
        //print("Failed to fetch user details: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error Details, $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.primaryColorLight,
      );
      //print("Error while fetching user details: $e");
    }
  }

  // to save session, if updated
  void saveSessionToStorage() {
    _storage.write("id", id.value);
    _storage.write("username", username.value);
    _storage.write("firstname", firstname.value);
    _storage.write("lastname", lastname.value);
    _storage.write("email", email.value);
    _storage.write("password", password.value);
    _storage.write("phone", phone.value);
    _storage.write("userStatus", userStatus.value);
  }

}

