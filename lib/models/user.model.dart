class User {
  String id;
  String email;
  String password;
  String? userName;
  String? familyName;
  String? givenName;
  String? nationality;
  String? occupation;
  double? age;
  String dateCreated;
  String dateUpdated;

  User({
    required this.id,
    required this.email,
    required this.password,
    this.userName,
    this.familyName,
    this.givenName,
    this.nationality,
    this.occupation,
    this.age,
    required this.dateCreated,
    required this.dateUpdated,
  });
}
