class ApiUrl {
  const ApiUrl._();
  static String domain = 'https://milkatmapi.fabfastrends.com/api/';
  static String midUrl = 'users/';

  static String login = "$domain${midUrl}login";
  static String firebaseLogin = "$domain${midUrl}firebase-login";
  static String attendanceClockIn = "$domain${midUrl}attendance/clock-in";
  static String vanRoutes(driverId) {
    return "${domain}vanRoutes/driver/$driverId/today";
  }

}
