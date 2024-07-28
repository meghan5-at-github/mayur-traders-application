// To parse this JSON data, do
//
//     final getUsersListResponseModel = getUsersListResponseModelFromJson(jsonString);

import 'dart:convert';

GetUsersListResponseModel getUsersListResponseModelFromJson(String str) =>
    GetUsersListResponseModel.fromJson(json.decode(str));

String getUsersListResponseModelToJson(GetUsersListResponseModel data) =>
    json.encode(data.toJson());

class GetUsersListResponseModel {
  int status;
  String message;
  List<UsersList>? data;

  GetUsersListResponseModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory GetUsersListResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["data"] != null) {
      return GetUsersListResponseModel(
        status: json["status"],
        message: json["message"],
        data: List<UsersList>.from(
            json["data"].map((x) => UsersList.fromJson(x))),
      );
    } else {
      return GetUsersListResponseModel(
          status: json["status"], message: json["message"]);
    }
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class UsersList {
  int id;
  String userId;
  String userProfile;
  String userName;
  String userRole;
  String userContact;
  String vehicleNumber;
  String userAddress;
  String userEmail;
  String joinedDate;
  String relieveDate;
  String isActive;

  UsersList({
    required this.id,
    required this.userId,
    required this.userProfile,
    required this.userName,
    required this.userRole,
    required this.userContact,
    required this.vehicleNumber,
    required this.userAddress,
    required this.userEmail,
    required this.joinedDate,
    required this.relieveDate,
    required this.isActive,
  });

  factory UsersList.fromJson(Map<String, dynamic> json) => UsersList(
        id: json["id"],
        userId: json["userId"],
        userProfile: json["userProfile"],
        userName: json["userName"],
        userRole: json["userRole"],
        userContact: json["userContact"],
        vehicleNumber: json["vehicle_number"],
        userAddress: json["userAddress"],
        userEmail: json["userEmail"],
        joinedDate: json["joined_date"],
        relieveDate: json["Relieve_date"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userProfile": userProfile,
        "userName": userName,
        "userRole": userRole,
        "userContact": userContact,
        "vehicle_number": vehicleNumber,
        "userAddress": userAddress,
        "userEmail": userEmail,
        "joined_date": joinedDate,
        "Relieve_date": relieveDate,
        "is_active": isActive,
      };
}
