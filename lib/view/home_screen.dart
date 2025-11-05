import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hellow_github/view/repo_details_screen.dart';
import 'package:hellow_github/widget/grid_item.dart';
import 'package:hellow_github/widget/repo_card.dart';

import '../controllers/repo_controller.dart';
import '../controllers/user_controller.dart';
import '../controllers/theme_controller.dart';

class HomePage extends StatelessWidget {
  final String userName;
  HomePage({required this.userName});

  final userController = Get.find<UserController>();
  final repoController = Get.put(RepoController());
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    repoController.fetchRepos(userName);

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(userController.user.value?.login ?? 'Repositories')),
        actions: [
          IconButton(
            icon: Obx(() => Icon(repoController.isGrid.value ? Icons.list : Icons.grid_view)),
            onPressed: () => repoController.toggleView(),
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
          Obx(() => IconButton(
                icon: Icon(themeController.themeMode.value == ThemeMode.dark ? Icons.wb_sunny : Icons.nights_stay),
                onPressed: () => themeController.toggleTheme(),
              )),
        ],
      ),
      body: Column(
        children: [
          _buildUserHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search repositories by name...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => repoController.setSearch(v),
            ),
          ),
          Expanded(child: Obx(() {
            if (repoController.loading.value) return Center(child: CircularProgressIndicator());
            if (repoController.error.value != null) return Center(child: Text(repoController.error.value!));
            if (repoController.filtered.isEmpty) return Center(child: Text('No repositories'));

            if (repoController.isGrid.value) {
              return GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.2),
                itemCount: repoController.filtered.length,
                itemBuilder: (_, idx) {
                  final repo = repoController.filtered[idx];
                  return GestureDetector(
                    onTap: () => Get.to(() => RepoDetailPage(repo: repo)),
                    child: RepoGridItem(repo: repo),
                  );
                },
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: repoController.filtered.length,
              itemBuilder: (_, idx) {
                final repo = repoController.filtered[idx];
                return GestureDetector(
                  onTap: () => Get.to(() => RepoDetailPage(repo: repo)),
                  child: RepoCard(repo: repo),
                );
              },
            );
          }))
        ],
      ),
    );
  }

  Widget _buildUserHeader() {
    final user = userController.user;
    return Obx(() {
      if (user.value == null) return SizedBox.shrink();
      return ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(user.value!.avatarUrl)),
        title: Text(user.value!.name ?? user.value!.login),
        subtitle: Text(user.value!.bio ?? ''),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Repos'),
            Text('${user.value!.publicRepos}'),
          ],
        ),
      );
    });
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Sort / Filter'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('Name Ascending'),
                  onTap: () {
                    repoController.setSort(RepoSort.nameAsc);
                    Get.back();
                  },
                ),
                ListTile(
                  title: Text('Name Descending'),
                  onTap: () {
                    repoController.setSort(RepoSort.nameDesc);
                    Get.back();
                  },
                ),
                ListTile(
                  title: Text('Created Date: Newest'),
                  onTap: () {
                    repoController.setSort(RepoSort.dateDesc);
                    Get.back();
                  },
                ),
                ListTile(
                  title: Text('Most Stars'),
                  onTap: () {
                    repoController.setSort(RepoSort.starsDesc);
                    Get.back();
                  },
                ),
              ],
            ),
          );
        });
  }
}
