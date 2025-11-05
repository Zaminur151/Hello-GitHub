import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/repo_model.dart';

class RepoGridItem extends StatelessWidget {
  final RepoModel repo;
  const RepoGridItem({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(repo.name, style: Theme.of(context).textTheme.titleMedium, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 6),
            Expanded(child: SingleChildScrollView(child: Text(repo.description ?? '', maxLines: 6, overflow: TextOverflow.ellipsis))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Star: ${repo.stargazersCount}'),
                Text(DateFormat.yMMMd().format(repo.updatedAt)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

