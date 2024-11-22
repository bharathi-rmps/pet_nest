import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet_nest/utils/apiEndpoint.dart';
import 'package:http/http.dart' as http;


class sessionController extends GetxController {

  // Reactive session state
  var isLoggedIn = false.obs;
  var id = ''.obs;
  var username = ''.obs;
  var firstname = ''.obs;
  var lastname = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var phone = ''.obs;

  // Storage instance for persisting session
  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // check persisted session status
    isLoggedIn.value = _storage.read('isLoggedIn') ?? false;
    id.value = _storage.read('id') ?? '';
    username.value = _storage.read('username') ?? '';
    firstname.value = _storage.read('firstname') ?? '';
    lastname.value = _storage.read('lastname') ?? '';
    email.value = _storage.read('email') ?? '';
    password.value = _storage.read('password') ?? '';
    phone.value = _storage.read('phone') ?? '';
  }

  // Set session
  void createSession(String userName) {
    isLoggedIn.value = true;
    username.value = userName;
    _storage.write('isLoggedIn', true);
    _storage.write('username', userName);
    getUserDetails(userName);
    print("Session created: $isLoggedIn, Username: $username");
  }

  // Clear session
  void logout() {
    isLoggedIn.value = false;
    id.value = '';
    username.value = '';
    firstname.value = '';
    lastname.value = '';
    email.value = '';
    password.value = '';
    phone.value = '';
    _storage.erase();
    print("Session cleared: $isLoggedIn");
  }

  // Get user details from API
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
        // parsing the JSON response to data
        var data = jsonDecode(response.body);

        // extracting and store details
        id.value = data['id'].toString();
        firstname.value = data['firstName'];
        lastname.value = data['lastName'];
        email.value = data['email'];
        password.value = data['password']; // Avoid storing sensitive info like passwords
        phone.value = data['phone'];

        // persist in storage
        _storage.write("id", id.value);
        _storage.write("firstname", firstname.value);
        _storage.write("lastname", lastname.value);
        _storage.write("email", email.value);
        _storage.write("password", password.value);
        _storage.write("phone", phone.value);

        print("User details fetched and stored: $data");
      } else {
        print("Failed to fetch user details: ${response.statusCode}");
      }
    } catch (e) {
      print("Error while fetching user details: $e");
    }
  }
}