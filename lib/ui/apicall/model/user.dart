class User {
  late String username;
  late String email;
  late String urlAvatar;

  User(this.username,this.email,this.urlAvatar);

  factory User.fromJson(json) => User(json['username'], json['email'], json['urlAvatar']);
}