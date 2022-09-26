class LocalUser {
  final String userid;
  final String phone;
  final String firstName;
  final bool admin;
  final String password;
  final String email;

  LocalUser(
      {required this.userid,
      required this.phone,
      required this.firstName,
      required this.password,
      required this.email,
      this.admin = false});

  factory LocalUser.fromJson(Map<String, dynamic> json) {
    return LocalUser(
        userid: json['userid'],
        phone: json['phone'],
        firstName: json['firstName'],
        admin: json['isAdmin'],
        password: json['password'],
        email: json['email']);
  }
}
