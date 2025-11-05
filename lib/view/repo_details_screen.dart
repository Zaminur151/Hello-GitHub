import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
            const SizedBox(height: 8),
           
            // Wrap(spacing: 12, children: [
            //   Chip(label: Text('Stars: \${repo.stargazersCount}')),
            //   Chip(label: Text('Forks: \${repo.forksCount}')),
            //   Chip(label: Text(repo.language ?? 'Unknown')),
            // ]),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.open_in_browser),
              label: Text('Open on GitHub'),
              onPressed: () async {
                final uri = Uri.parse(repo.htmlUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
            )
        ]),
      ),
    );
  }
}