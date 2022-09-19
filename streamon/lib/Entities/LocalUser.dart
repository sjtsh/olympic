
class LocalUser {
  final String userid;
  final String phone;
  final String firstName;

  LocalUser(
      {required this.userid,
        required this.phone,
        required this.firstName});

  factory LocalUser.fromJson(Map<String, dynamic> json) {
    return LocalUser(
      userid: json['userid'],
      phone: json['phone'],
      firstName: json['firstName'],
    );
  }
}
