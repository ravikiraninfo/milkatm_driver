// To parse this JSON data, do
//
//     final vanDetails = vanDetailsFromJson(jsonString);

import 'dart:convert';

VanDetails vanDetailsFromJson(String str) => VanDetails.fromJson(json.decode(str));

String vanDetailsToJson(VanDetails data) => json.encode(data.toJson());

class VanDetails {
  bool? status;
  List<Datum>? data;
  String? message;

  VanDetails({
    this.status,
    this.data,
    this.message,
  });

  factory VanDetails.fromJson(Map<String, dynamic> json) => VanDetails(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
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
  List<WalkInOrder>? walkInOrders;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    walkInOrders: json["walkInOrders"] == null ? [] : List<WalkInOrder>.from(json["walkInOrders"]!.map((x) => WalkInOrder.fromJson(x))),
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
    "walkInOrders": walkInOrders == null ? [] : List<dynamic>.from(walkInOrders!.map((x) => x.toJson())),
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
  OrderId? orderId;
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
    orderId: json["orderId"] == null ? null : OrderId.fromJson(json["orderId"]),
    userId: json["userId"],
    fullName: json["fullName"],
    mobile: json["mobile"],
    liter: json["liter"],
    status: json["status"],
    isDelivered: json["isDelivered"],
    isUserCollected: json["isUserCollected"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId?.toJson(),
    "userId": userId,
    "fullName": fullName,
    "mobile": mobile,
    "liter": liter,
    "status": status,
    "isDelivered": isDelivered,
    "isUserCollected": isUserCollected,
  };
}

class OrderId {
  String? id;
  String? orderNumber;
  String? userId;
  String? subscriptionUserId;
  String? cityId;
  String? areaId;
  int? liter;
  DateTime? orderDate;
  int? pricePerLiter;
  int? price;
  int? discountPerLiter;
  String? pickupPointId;
  OrderIdPickupPoint? pickupPoint;
  Type? milkType;
  Type? deliveryType;
  Type? pickupType;
  String? frequency;
  Address? address;
  String? name;
  String? mobile;
  bool? isDelivered;
  bool? isUserCollected;
  String? status;
  bool? isDeleted;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;

  OrderId({
    this.id,
    this.orderNumber,
    this.userId,
    this.subscriptionUserId,
    this.cityId,
    this.areaId,
    this.liter,
    this.orderDate,
    this.pricePerLiter,
    this.price,
    this.discountPerLiter,
    this.pickupPointId,
    this.pickupPoint,
    this.milkType,
    this.deliveryType,
    this.pickupType,
    this.frequency,
    this.address,
    this.name,
    this.mobile,
    this.isDelivered,
    this.isUserCollected,
    this.status,
    this.isDeleted,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderId.fromJson(Map<String, dynamic> json) => OrderId(
    id: json["_id"],
    orderNumber: json["orderNumber"],
    userId: json["userId"],
    subscriptionUserId: json["subscriptionUserId"],
    cityId: json["cityId"],
    areaId: json["areaId"],
    liter: json["liter"],
    orderDate: json["orderDate"] == null ? null : DateTime.parse(json["orderDate"]),
    pricePerLiter: json["pricePerLiter"],
    price: json["price"],
    discountPerLiter: json["discountPerLiter"],
    pickupPointId: json["pickupPointId"],
    pickupPoint: json["pickupPoint"] == null ? null : OrderIdPickupPoint.fromJson(json["pickupPoint"]),
    milkType: json["milkType"] == null ? null : Type.fromJson(json["milkType"]),
    deliveryType: json["deliveryType"] == null ? null : Type.fromJson(json["deliveryType"]),
    pickupType: json["pickupType"] == null ? null : Type.fromJson(json["pickupType"]),
    frequency: json["frequency"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    name: json["name"],
    mobile: json["mobile"],
    isDelivered: json["isDelivered"],
    isUserCollected: json["isUserCollected"],
    status: json["status"],
    isDeleted: json["isDeleted"],
    v: json["__v"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "orderNumber": orderNumber,
    "userId": userId,
    "subscriptionUserId": subscriptionUserId,
    "cityId": cityId,
    "areaId": areaId,
    "liter": liter,
    "orderDate": orderDate?.toIso8601String(),
    "pricePerLiter": pricePerLiter,
    "price": price,
    "discountPerLiter": discountPerLiter,
    "pickupPointId": pickupPointId,
    "pickupPoint": pickupPoint?.toJson(),
    "milkType": milkType?.toJson(),
    "deliveryType": deliveryType?.toJson(),
    "pickupType": pickupType?.toJson(),
    "frequency": frequency,
    "address": address?.toJson(),
    "name": name,
    "mobile": mobile,
    "isDelivered": isDelivered,
    "isUserCollected": isUserCollected,
    "status": status,
    "isDeleted": isDeleted,
    "__v": v,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Address {
  String? plotNo;
  String? address;
  String? landmark;
  String? pinCode;
  String? type;

  Address({
    this.plotNo,
    this.address,
    this.landmark,
    this.pinCode,
    this.type,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    plotNo: json["plotNo"],
    address: json["address"],
    landmark: json["landmark"],
    pinCode: json["pinCode"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "plotNo": plotNo,
    "address": address,
    "landmark": landmark,
    "pinCode": pinCode,
    "type": type,
  };
}

class Type {
  String? name;
  int? addOn;

  Type({
    this.name,
    this.addOn,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    name: json["name"],
    addOn: json["addOn"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "addOn": addOn,
  };
}

class OrderIdPickupPoint {
  String? name;
  String? address;
  double? lat;
  double? long;

  OrderIdPickupPoint({
    this.name,
    this.address,
    this.lat,
    this.long,
  });

  factory OrderIdPickupPoint.fromJson(Map<String, dynamic> json) => OrderIdPickupPoint(
    name: json["name"],
    address: json["address"],
    lat: json["lat"]?.toDouble(),
    long: json["long"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "lat": lat,
    "long": long,
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

class WalkInOrder {
  String? orderNumber;
  String? walkInCustomerId;
  String? name;
  String? mobile;
  int? milkInLiter;
  MilkType? milkType;
  int? pricePerLiter;
  int? amount;
  DateTime? createdAt;

  WalkInOrder({
    this.orderNumber,
    this.walkInCustomerId,
    this.name,
    this.mobile,
    this.milkInLiter,
    this.milkType,
    this.pricePerLiter,
    this.amount,
    this.createdAt,
  });

  factory WalkInOrder.fromJson(Map<String, dynamic> json) => WalkInOrder(
    orderNumber: json["orderNumber"],
    walkInCustomerId: json["walkInCustomerId"],
    name: json["name"],
    mobile: json["mobile"],
    milkInLiter: json["milkInLiter"],
    milkType: json["milkType"] == null ? null : MilkType.fromJson(json["milkType"]),
    pricePerLiter: json["pricePerLiter"],
    amount: json["amount"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "orderNumber": orderNumber,
    "walkInCustomerId": walkInCustomerId,
    "name": name,
    "mobile": mobile,
    "milkInLiter": milkInLiter,
    "milkType": milkType?.toJson(),
    "pricePerLiter": pricePerLiter,
    "amount": amount,
    "createdAt": createdAt?.toIso8601String(),
  };
}

class MilkType {
  String? name;

  MilkType({
    this.name,
  });

  factory MilkType.fromJson(Map<String, dynamic> json) => MilkType(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
