import 'dart:convert';

class UserModel {
  String firstName;
  String lastName;
  String email;
  String uid;
  String username;
  String phone;
  num amount;
  num netCommission;
  num commission;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.uid,
    required this.username,
    required this.phone,
    required this.amount,
    required this.netCommission,
    required this.commission,
  });

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? uid,
    String? username,
    String? phone,
    num? amount,
    num? netCommission,
    num? commission,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      amount: amount ?? this.amount,
      netCommission: netCommission ?? this.netCommission,
      commission: commission ?? this.commission,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'uid': uid,
      'username': username,
      'phone': phone,
      'amount': amount,
      'netCommission': netCommission,
      'commission': commission,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      uid: map['uid'],
      username: map['username'],
      phone: map['phone'],
      amount: map['amount'],
      netCommission: map['netCommission'],
      commission: map['commission'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(firstName: $firstName, lastName: $lastName, email: $email, uid: $uid, username: $username, phone: $phone, amount: $amount, netCommission: $netCommission, commission: $commission)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.uid == uid &&
        other.username == username &&
        other.phone == phone &&
        other.amount == amount &&
        other.netCommission == netCommission &&
        other.commission == commission;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        uid.hashCode ^
        username.hashCode ^
        phone.hashCode ^
        amount.hashCode ^
        netCommission.hashCode ^
        commission.hashCode;
  }
}
