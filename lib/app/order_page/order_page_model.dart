// To parse this JSON data, do
//
//     final allOrdersModel = allOrdersModelFromJson(jsonString);

import 'dart:convert';

AllOrdersModel allOrdersModelFromJson(String str) => AllOrdersModel.fromJson(json.decode(str));

String allOrdersModelToJson(AllOrdersModel data) => json.encode(data.toJson());

class AllOrdersModel {
  bool? status;
  Data? data;
  String? message;

  AllOrdersModel({
    this.status,
    this.data,
    this.message,
  });

  factory AllOrdersModel.fromJson(Map<String, dynamic> json) => AllOrdersModel(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  List<Datum>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Datum {
  String? id;
  String? orderNumber;
  UserId? userId;
  SubscriptionUserId? subscriptionUserId;
  String? cityId;
  String? areaId;
  int? liter;
  DateTime? orderDate;
  int? pricePerLiter;
  int? price;
  int? discountPerLiter;
  String? pickupPointId;
  PickupPoint? pickupPoint;
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

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    orderNumber: json["orderNumber"],
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    subscriptionUserId: json["subscriptionUserId"] == null ? null : SubscriptionUserId.fromJson(json["subscriptionUserId"]),
    cityId: json["cityId"],
    areaId: json["areaId"],
    liter: json["liter"],
    orderDate: json["orderDate"] == null ? null : DateTime.parse(json["orderDate"]),
    pricePerLiter: json["pricePerLiter"],
    price: json["price"],
    discountPerLiter: json["discountPerLiter"],
    pickupPointId: json["pickupPointId"],
    pickupPoint: json["pickupPoint"] == null ? null : PickupPoint.fromJson(json["pickupPoint"]),
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
    "userId": userId?.toJson(),
    "subscriptionUserId": subscriptionUserId?.toJson(),
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

class PickupPoint {
  String? name;
  String? address;
  double? lat;
  double? long;

  PickupPoint({
    this.name,
    this.address,
    this.lat,
    this.long,
  });

  factory PickupPoint.fromJson(Map<String, dynamic> json) => PickupPoint(
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

class SubscriptionUserId {
  SubscriptionPlan? subscriptionPlan;
  String? id;
  String? userId;
  String? cityId;
  String? areaId;
  String? deliveryFrequency;
  List<String>? customDays;
  int? quantity;
  int? amountPaid;
  int? couponAmount;
  DateTime? expiryDate;
  bool? isApproved;
  bool? isRejected;
  String? createdBy;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  DateTime? approvedAt;
  String? approvedBy;

  SubscriptionUserId({
    this.subscriptionPlan,
    this.id,
    this.userId,
    this.cityId,
    this.areaId,
    this.deliveryFrequency,
    this.customDays,
    this.quantity,
    this.amountPaid,
    this.couponAmount,
    this.expiryDate,
    this.isApproved,
    this.isRejected,
    this.createdBy,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.approvedAt,
    this.approvedBy,
  });

  factory SubscriptionUserId.fromJson(Map<String, dynamic> json) => SubscriptionUserId(
    subscriptionPlan: json["subscriptionPlan"] == null ? null : SubscriptionPlan.fromJson(json["subscriptionPlan"]),
    id: json["_id"],
    userId: json["userId"],
    cityId: json["cityId"],
    areaId: json["areaId"],
    deliveryFrequency: json["deliveryFrequency"],
    customDays: json["customDays"] == null ? [] : List<String>.from(json["customDays"]!.map((x) => x)),
    quantity: json["quantity"],
    amountPaid: json["amountPaid"],
    couponAmount: json["couponAmount"],
    expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
    isApproved: json["isApproved"],
    isRejected: json["isRejected"],
    createdBy: json["createdBy"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    approvedAt: json["approvedAt"] == null ? null : DateTime.parse(json["approvedAt"]),
    approvedBy: json["approvedBy"],
  );

  Map<String, dynamic> toJson() => {
    "subscriptionPlan": subscriptionPlan?.toJson(),
    "_id": id,
    "userId": userId,
    "cityId": cityId,
    "areaId": areaId,
    "deliveryFrequency": deliveryFrequency,
    "customDays": customDays == null ? [] : List<dynamic>.from(customDays!.map((x) => x)),
    "quantity": quantity,
    "amountPaid": amountPaid,
    "couponAmount": couponAmount,
    "expiryDate": expiryDate?.toIso8601String(),
    "isApproved": isApproved,
    "isRejected": isRejected,
    "createdBy": createdBy,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "approvedAt": approvedAt?.toIso8601String(),
    "approvedBy": approvedBy,
  };
}

class SubscriptionPlan {
  MilkType? milkType;
  DeliveryTime? deliveryTime;
  Type? deliveryType;
  Type? pickupType;
  String? planName;
  int? days;
  int? pricePerLiter;
  double? discountPerLiter;

  SubscriptionPlan({
    this.milkType,
    this.deliveryTime,
    this.deliveryType,
    this.pickupType,
    this.planName,
    this.days,
    this.pricePerLiter,
    this.discountPerLiter,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) => SubscriptionPlan(
    milkType: json["milkType"] == null ? null : MilkType.fromJson(json["milkType"]),
    deliveryTime: json["deliveryTime"] == null ? null : DeliveryTime.fromJson(json["deliveryTime"]),
    deliveryType: json["deliveryType"] == null ? null : Type.fromJson(json["deliveryType"]),
    pickupType: json["pickupType"] == null ? null : Type.fromJson(json["pickupType"]),
    planName: json["planName"],
    days: json["days"],
    pricePerLiter: json["pricePerLiter"],
    discountPerLiter: json["discountPerLiter"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "milkType": milkType?.toJson(),
    "deliveryTime": deliveryTime?.toJson(),
    "deliveryType": deliveryType?.toJson(),
    "pickupType": pickupType?.toJson(),
    "planName": planName,
    "days": days,
    "pricePerLiter": pricePerLiter,
    "discountPerLiter": discountPerLiter,
  };
}

class DeliveryTime {
  String? name;
  String? fromTime;
  String? toTime;

  DeliveryTime({
    this.name,
    this.fromTime,
    this.toTime,
  });

  factory DeliveryTime.fromJson(Map<String, dynamic> json) => DeliveryTime(
    name: json["name"],
    fromTime: json["fromTime"],
    toTime: json["toTime"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "fromTime": fromTime,
    "toTime": toTime,
  };
}

class MilkType {
  int? gst;
  String? name;
  int? addOn;

  MilkType({
    this.gst,
    this.name,
    this.addOn,
  });

  factory MilkType.fromJson(Map<String, dynamic> json) => MilkType(
    gst: json["gst"],
    name: json["name"],
    addOn: json["addOn"],
  );

  Map<String, dynamic> toJson() => {
    "gst": gst,
    "name": name,
    "addOn": addOn,
  };
}

class UserId {
  String? id;
  String? fullName;
  String? mobile;
  String? email;

  UserId({
    this.id,
    this.fullName,
    this.mobile,
    this.email,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    fullName: json["fullName"],
    mobile: json["mobile"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "mobile": mobile,
    "email": email,
  };
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalRecords;
  int? limit;

  Pagination({
    this.currentPage,
    this.totalPages,
    this.totalRecords,
    this.limit,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    totalRecords: json["totalRecords"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "totalPages": totalPages,
    "totalRecords": totalRecords,
    "limit": limit,
  };
}
