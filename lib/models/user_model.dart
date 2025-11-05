class UserModel {
  final String login;
  final String avatarUrl;
  final String? name;
  final String? bio;
  final int publicRepos;
  UserModel({
    required this.login,
    required this.avatarUrl,
    this.bio,
    this.name,
    required this.publicRepos
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      login : json['login']??"",
      avatarUrl : json['avatar_url']?? '',
      name : json['name'],
      bio : json['bio'],
      publicRepos : json['public_repos']?? 0,
    );

  }
}