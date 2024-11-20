class apiEndpoint{
  static final String baseUrl = "https://petstore.swagger.io/v2";
  static AuthEndPoints authEndPoints = AuthEndPoints();
}

class AuthEndPoints{
  final String reg = "/user";
  final String login = "/user/login";
  final String logout = "/user/logout";
}