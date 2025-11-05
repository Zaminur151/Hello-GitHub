import 'package:flutter/material.dart';
import '../models/repo_model.dart';

class RepoDetailPage extends StatelessWidget {
  final RepoModel repo;
  const RepoDetailPage({required this.repo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(repo.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Text("Id: ${repo.id}"),
            const SizedBox(height: 8),
            Text("Name: ${repo.name}"),
            const SizedBox(height: 8),
            Text("Description: ${repo.description??'No Description'}"),
            const SizedBox(height: 8),
            Text("Star: ${repo.stargazersCount}"),
            const SizedBox(height: 8),
            Text("Fork: ${repo.forksCount}"),
            const SizedBox(height: 8),
            Text("Created: ${repo.createdAt}"),
            const SizedBox(height: 8),
            Text("Updated: ${repo.updatedAt}"),
            const SizedBox(height: 8),
            Text("Language: ${repo.language??'Dart'}"),
            const SizedBox(height: 8),
            Text("Url: ${repo.htmlUrl}"), 
        ]),
      ),
    );
  }
}