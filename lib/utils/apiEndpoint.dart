class apiEndpoint{
  static final String baseUrl = "https://petstore.swagger.io/v2";
  static AuthEndPoints authEndPoints = AuthEndPoints();
  static UserEndpoints userEndpoints = UserEndpoints();
  static PetEndPoints petEndpoints = PetEndPoints();
  static StoreEndPoints storeEndpoints = StoreEndPoints();
}

class AuthEndPoints{
  final String reg = "/user";
  final String login = "/user/login";
  final String logout = "/user/logout";
}

class UserEndpoints{
  final String getUserDetails = "/user/";
  final String updateUserDetails = "/user/";
  final String deleteUserDetails = "/user/";
}

class PetEndPoints{
  final String addPet = "/pet";
  final String editPet = "/pet";
  final String deletePet = "/pet/";
  final String getPetByStatusAvailable = "/pet/findByStatus?status=bharathiRMPSavailable";
  final String getPetByStatusSold = "/pet/findByStatus?status=bharathiRMPSsold";
  final String getPetById = "/pet/";
}

class StoreEndPoints{
  final String placeOrder = "/store/order";
}