// const String baseUrl = "http://192.168.100.66:8000"; // for development
/// endpoint 4 the api
// const String baseUrl = "https://web-production-f123.up.railway.app/"; // Limited and had db issues
const String baseUrl = "https://osumbadexter.pythonanywhere.com";

class APIRoutes {
  // static String user = "$baseUrl/user";

  // user auth
  static const String login = "$baseUrl/user/login/";
  static const String register = "$baseUrl/user/register/";
  static const String profileUpdate = "$baseUrl/user/profile/";
  static const String forgotPassword =
      "$baseUrl/user/password/password_change/";

  static String products = "$baseUrl/products/";

  static String cart = "$baseUrl/cart/";
  static String notifications = "$baseUrl/notifications/";
}

// Load time
int TIMEOUT = 100000;

// Shared preference keys
const TOKEN = "TOKEN";
const USER = "USER";
const IS_STAFF = "IS_STAFF";
const ONBOARD = "BOARDED";
