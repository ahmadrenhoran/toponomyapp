class User {
  int id = 0;
  String username = "";
  String email = "";
  String password = "";

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  factory User.loginForm(String email, String password) {
    return User(
      id: 0,
      username: "",
      email: email,
      password: password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
