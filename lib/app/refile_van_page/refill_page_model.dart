// To parse this JSON data, do
//
//     final vanDetails = vanDetailsFromJson(jsonString);

import 'dart:convert';

List<VanDetails> vanDetailsFromJson(String str) => List<VanDetails>.from(json.decode(str).map((x) => VanDetails.fromJson(x)));

String vanDetailsToJson(List<VanDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VanDetails {
  Driver? driver;
  String? id;
  DateTime? date;
  Van? van;
  Route? route;
  int? totalCapacity;
  int? currentCapacity;
  int? subscriptionMilkLiter;
  int? deliveredMilkLiter;
  int? walkInMilkLiter;
  int? surplusMilkLiter;
  int? walletBalance;
  CreatedBy? createdBy;
  bool? isDeleted;
  List<dynamic>? walkInOrders;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  VanDetails({
    this.driver,
    this.id,
    this.date,
    this.van,
    this.route,
    this.totalCapacity,
    this.currentCapacity,
    this.subscriptionMilkLiter,
    this.deliveredMilkLiter,
    this.walkInMilkLiter,
    this.surplusMilkLiter,
    this.walletBalance,
    this.createdBy,
    this.isDeleted,
    this.walkInOrders,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory VanDetails.fromJson(Map<String, dynamic> json) => VanDetails(
    driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
    id: json["_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    van: json["van"] == null ? null : Van.fromJson(json["van"]),
    route: json["route"] == null ? null : Route.fromJson(json["route"]),
    totalCapacity: json["totalCapacity"],
    currentCapacity: json["currentCapacity"],
    subscriptionMilkLiter: json["subscriptionMilkLiter"],
    deliveredMilkLiter: json["deliveredMilkLiter"],
    walkInMilkLiter: json["walkInMilkLiter"],
    surplusMilkLiter: json["surplusMilkLiter"],
    walletBalance: json["walletBalance"],
    createdBy: json["createdBy"] == null ? null : CreatedBy.fromJson(json["createdBy"]),
    isDeleted: json["isDeleted"],
    walkInOrders: json["walkInOrders"] == null ? [] : List<dynamic>.from(json["walkInOrders"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "driver": driver?.toJson(),
    "_id": id,
    "date": date?.toIso8601String(),
    "van": van?.toJson(),
    "route": route?.toJson(),
    "totalCapacity": totalCapacity,
    "currentCapacity": currentCapacity,
    "subscriptionMilkLiter": subscriptionMilkLiter,
    "deliveredMilkLiter": deliveredMilkLiter,
    "walkInMilkLiter": walkInMilkLiter,
    "surplusMilkLiter": surplusMilkLiter,
    "walletBalance": walletBalance,
    "createdBy": createdBy?.toJson(),
    "isDeleted": isDeleted,
    "walkInOrders": walkInOrders == null ? [] : List<dynamic>.from(walkInOrders!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class CreatedBy {
  String? id;
  String? fullName;
  String? mobile;
  String? role;

  CreatedBy({
    this.id,
    this.fullName,
    this.mobile,
    this.role,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["_id"],
    fullName: json["fullName"],
    mobile: json["mobile"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "mobile": mobile,
    "role": role,
  };
}

class Driver {
  String? driverUserId;
  String? name;
  String? mobile;

  Driver({
    this.driverUserId,
    this.name,
    this.mobile,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    driverUserId: json["driverUserId"],
    name: json["name"],
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "driverUserId": driverUserId,
    "name": name,
    "mobile": mobile,
  };
}

class Route {
  String? routeId;
  String? name;
  List<PickupPoint>? pickupPoints;

  Route({
    this.routeId,
    this.name,
    this.pickupPoints,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    routeId: json["routeId"],
    name: json["name"],
    pickupPoints: json["pickupPoints"] == null ? [] : List<PickupPoint>.from(json["pickupPoints"]!.map((x) => PickupPoint.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "routeId": routeId,
    "name": name,
    "pickupPoints": pickupPoints == null ? [] : List<dynamic>.from(pickupPoints!.map((x) => x.toJson())),
  };
}

class PickupPoint {
  String? pickupPointId;
  String? name;
  String? address;
  double? lat;
  double? long;
  List<User>? users;
  int? pendingCount;
  int? deliveredCount;
  int? pausedCount;
  int? missedCount;
  bool? isDone;

  PickupPoint({
    this.pickupPointId,
    this.name,
    this.address,
    this.lat,
    this.long,
    this.users,
    this.pendingCount,
    this.deliveredCount,
    this.pausedCount,
    this.missedCount,
    this.isDone,
  });

  factory PickupPoint.fromJson(Map<String, dynamic> json) => PickupPoint(
    pickupPointId: json["pickupPointId"],
    name: json["name"],
    address: json["address"],
    lat: json["lat"]?.toDouble(),
    long: json["long"]?.toDouble(),
    users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
    pendingCount: json["pendingCount"],
    deliveredCount: json["deliveredCount"],
    pausedCount: json["pausedCount"],
    missedCount: json["missedCount"],
    isDone: json["isDone"],
  );

  Map<String, dynamic> toJson() => {
    "pickupPointId": pickupPointId,
    "name": name,
    "address": address,
    "lat": lat,
    "long": long,
    "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
    "pendingCount": pendingCount,
    "deliveredCount": deliveredCount,
    "pausedCount": pausedCount,
    "missedCount": missedCount,
    "isDone": isDone,
  };
}

class User {
  String? orderId;
  String? userId;
  String? fullName;
  String? mobile;
  int? liter;
  String? status;
  bool? isDelivered;
  bool? isUserCollected;

  User({
    this.orderId,
    this.userId,
    this.fullName,
    this.mobile,
    this.liter,
    this.status,
    this.isDelivered,
    this.isUserCollected,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    orderId: json["orderId"],
    userId: json["userId"],
    fullName: json["fullName"],
    mobile: json["mobile"],
    liter: json["liter"],
    status: json["status"],
    isDelivered: json["isDelivered"],
    isUserCollected: json["isUserCollected"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "userId": userId,
    "fullName": fullName,
    "mobile": mobile,
    "liter": liter,
    "status": status,
    "isDelivered": isDelivered,
    "isUserCollected": isUserCollected,
  };
}

class Van {
  String? vanRegisterId;
  String? vanName;
  String? number;
  int? capacityInLiters;

  Van({
    this.vanRegisterId,
    this.vanName,
    this.number,
    this.capacityInLiters,
  });

  factory Van.fromJson(Map<String, dynamic> json) => Van(
    vanRegisterId: json["vanRegisterId"],
    vanName: json["vanName"],
    number: json["number"],
    capacityInLiters: json["capacityInLiters"],
  );

  Map<String, dynamic> toJson() => {
    "vanRegisterId": vanRegisterId,
    "vanName": vanName,
    "number": number,
    "capacityInLiters": capacityInLiters,
  };
}
