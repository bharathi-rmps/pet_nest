class apiEndpoint{
  static final String baseUrl = "https://petstore.swagger.io/v2";
  static AuthEndPoints authEndPoints = AuthEndPoints();
  static UserEndpoints userEndpoints = UserEndpoints();
  static PetEndPoints petEndpoints = PetEndPoints();
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
  final String getPetByStatus = "/pet/findByStatus?status=bharathiRMPS";
  final String getPetById = "/pet/";
  final String deletePet = "/pet/";
}