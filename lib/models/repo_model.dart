class RepoModel {
  final int id;
  final String name;
  final String fullName;
  final String? description;
  final String htmlUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int stargazersCount;
  final int forksCount;
  final String? language;

  RepoModel({
    required this.id,
    required this.name,
    required this.fullName,
    this.description,
    required this.htmlUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.stargazersCount,
    required this.forksCount,
    this.language,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      id: json['id'] as int,
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      description: json['description'] as String?,
      htmlUrl: json['html_url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      stargazersCount: json['stargazers_count'] as int? ?? 0,
      forksCount: json['forks_count'] as int? ?? 0,
      language: json['language'] as String?,
    );
  }
}
