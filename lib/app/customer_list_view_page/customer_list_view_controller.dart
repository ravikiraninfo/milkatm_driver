import 'package:get/get.dart';

import '../refile_van_page/refill_page_model.dart';

class CustomerListViewController extends GetxController {
  CustomerListViewController();

  final List<String> filterOptions = <String>[
    'All Customer',
    'Delivered',
    'Active',
    'Paused',
    'Missed',
  ];

  final RxString selectedFilter = 'All Customer'.obs;
  final RxString draftFilter = 'All Customer'.obs;
  final RxList<User> _allUsers = <User>[].obs;
  final RxList<User> filteredUsers = <User>[].obs;

  static const Map<String, List<String>> _statusLookup = <String, List<String>>{
    'Delivered': <String>['delivered'],
    'Active': <String>['active'],
    'Paused': <String>['pause', 'paused'],
    'Missed': <String>['missed'],
  };

  bool get hasUsers => _allUsers.isNotEmpty;
  int get totalUsers => _allUsers.length;

  void setUsers(List<User> users) {
    _allUsers.assignAll(users);
    _applyFilter();
  }

  void beginFilterSelection() {
    draftFilter.value = selectedFilter.value;
  }

  void selectFilterOption(String option) {
    draftFilter.value = option;
  }

  void applyDraftFilter() {
    selectedFilter.value = draftFilter.value;
    _applyFilter();
  }

  void _applyFilter() {
    final String currentFilter = selectedFilter.value;
    if (currentFilter == 'All Customer') {
      filteredUsers.assignAll(_allUsers);
      return;
    }

    final List<String>? acceptedStatuses = _statusLookup[currentFilter];
    if (acceptedStatuses == null || acceptedStatuses.isEmpty) {
      filteredUsers.assignAll(_allUsers);
      return;
    }

    filteredUsers.assignAll(
      _allUsers.where((User user) {
        final String status = (user.orderId?.status ?? user.status ?? '').toLowerCase();
        return acceptedStatuses.contains(status);
      }),
    );
  }
}