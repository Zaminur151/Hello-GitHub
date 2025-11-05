import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/repo_model.dart';

class RepoCard extends StatelessWidget {
  final RepoModel repo;
  const RepoCard({required this.repo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(repo.name, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            if (repo.description != null) Text(repo.description!),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Stars: ${repo.stargazersCount}'),
                Text('Forks: ${repo.forksCount}'),
                Text(DateFormat.yMMMd().format(repo.updatedAt)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

