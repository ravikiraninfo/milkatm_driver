class ApiUrl {
  const ApiUrl._();
  static String domain = 'https://milkatmapi.fabfastrends.com/api/';
  static String midUrl = 'users/';

  static String login = "$domain${midUrl}login";
  static String firebaseLogin = "$domain${midUrl}firebase-login";
  static String attendanceClockIn = "$domain${midUrl}attendance/clock-in";
  static String attendanceClockOut = "$domain${midUrl}attendance/clock-out";
  static String vanRoutes(driverId) {
    return "${domain}vanRoutes/driver/$driverId/today";
  }
  static String checkStatus(driverId) {
    return "${domain}vanRoutes/driver/$driverId/today/status";
  }
  static String summary(driverId) {
    return "${domain}vanRoutes/driver/$driverId/today/summary";
  }
  static String createWalkInOrder(driverId) {
    return "${domain}vanRoutes/$driverId/walkin-orders";
  }
  static String gertProfileData(driverId) {
    return "${domain}users/$driverId/profile";
  }
  static String allOrders({
    required String driverId,
    required int page,
    required int limit,
    String? search,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    final Map<String, String> params = <String, String>{
      'page': '$page',
      'limit': '$limit',
      'driverId': driverId,
    };
    if (search != null && search.isNotEmpty) {
      params['search'] = search;
    }
    if (status != null && status.isNotEmpty) {
      params['status'] = status;
    }
    if (startDate != null) {
      params['startDate'] = startDate.toIso8601String();
    }
    if (endDate != null) {
      params['endDate'] = endDate.toIso8601String();
    }
    final Uri uri = Uri.parse('${domain}orders').replace(queryParameters: params);
    return uri.toString();
  }

}
