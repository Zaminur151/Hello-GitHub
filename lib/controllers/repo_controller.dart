import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../services/api_service.dart';
import '../models/repo_model.dart';

enum RepoSort { nameAsc, nameDesc, dateAsc, dateDesc, starsDesc }

class RepoController extends GetxController {
  final ApiService api = ApiService();
  final repos = <RepoModel>[].obs;
  final filtered = <RepoModel>[].obs;
  final loading = false.obs;
  final error = RxnString();
  final isGrid = false.obs;
  final searchQuery = ''.obs;
  final currentSort = RepoSort.dateDesc.obs;

  Future<void> fetchRepos(String userName) async {
    loading.value = true;
    error.value = null;
    try {
      final response = await api.getRepos(userName);
      final List data = response.data as List;
      repos.value = data.map((e) => RepoModel.fromJson(e)).toList();
      applyFilters();
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        error.value = 'Repositories not found';
      } else {
        error.value = e.message;
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  void toggleView() => isGrid.value = !isGrid.value;

  void applyFilters({String? query, RepoSort? sort}) {
    final q = query ?? searchQuery.value;
    final s = sort ?? currentSort.value;

    List<RepoModel> list = List.from(repos);

    if (q.isNotEmpty) {
      list = list.where((r) => r.name.toLowerCase().contains(q.toLowerCase())).toList();
    }

    switch (s) {
      case RepoSort.nameAsc:
        list.sort((a, b) => a.name.compareTo(b.name));
        break;
      case RepoSort.nameDesc:
        list.sort((a, b) => b.name.compareTo(a.name));
        break;
      case RepoSort.dateAsc:
        list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case RepoSort.dateDesc:
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case RepoSort.starsDesc:
        list.sort((a, b) => b.stargazersCount.compareTo(a.stargazersCount));
        break;
    }

    filtered.value = list;
  }

  void setSearch(String q) {
    searchQuery.value = q;
    applyFilters();
  }

  void setSort(RepoSort s) {
    currentSort.value = s;
    applyFilters();
  }
}
