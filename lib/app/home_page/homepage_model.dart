// To parse this JSON data, do
//
//     final homepageModel = homepageModelFromJson(jsonString);

import 'dart:convert';

List<HomepageModel> homepageModelFromJson(String str) => List<HomepageModel>.from(json.decode(str).map((x) => HomepageModel.fromJson(x)));

String homepageModelToJson(List<HomepageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomepageModel {
  String? id;
  DateTime? date;
  num? totalCapacity;
  num? currentCapacity;
  num? subscriptionMilkLiter;
  num? deliveredMilkLiter;
  num? walkInMilkLiter;
  num? surplusMilkLiter;
  num? walletBalance;
  num? totalUserCount;
  num? walkInUserCount;

  HomepageModel({
    this.id,
    this.date,
    this.totalCapacity,
    this.currentCapacity,
    this.subscriptionMilkLiter,
    this.deliveredMilkLiter,
    this.walkInMilkLiter,
    this.surplusMilkLiter,
    this.walletBalance,
    this.totalUserCount,
    this.walkInUserCount,
  });

  factory HomepageModel.fromJson(Map<String, dynamic> json) => HomepageModel(
    id: json["_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    totalCapacity: json["totalCapacity"],
    currentCapacity: json["currentCapacity"],
    subscriptionMilkLiter: json["subscriptionMilkLiter"],
    deliveredMilkLiter: json["deliveredMilkLiter"],
    walkInMilkLiter: json["walkInMilkLiter"],
    surplusMilkLiter: json["surplusMilkLiter"],
    walletBalance: json["walletBalance"],
    totalUserCount: json["totalUserCount"],
    walkInUserCount: json["walkInUserCount"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "date": date?.toIso8601String(),
    "totalCapacity": totalCapacity,
    "currentCapacity": currentCapacity,
    "subscriptionMilkLiter": subscriptionMilkLiter,
    "deliveredMilkLiter": deliveredMilkLiter,
    "walkInMilkLiter": walkInMilkLiter,
    "surplusMilkLiter": surplusMilkLiter,
    "walletBalance": walletBalance,
    "totalUserCount": totalUserCount,
    "walkInUserCount": walkInUserCount,
  };
}
