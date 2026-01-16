import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'order_page_model.dart';
import 'package:dio/dio.dart' as d;
import 'package:milkshop_driver/data/local/shared_preference/shared_preference.dart';
import 'package:milkshop_driver/data/local/shared_preference/shared_preference_key.dart';
import '../../api/api_url.dart';
import '../../common/common_snackbar.dart';
import '../../services/base_services.dart';

class OrderPageController extends GetxController {
	OrderPageController();

	final Rx<AllOrdersModel> allOrdersModel = AllOrdersModel().obs;
	final RxList<Datum> orders = <Datum>[].obs;
	final RxBool isLoading = false.obs;
	final RxBool isLoadingMore = false.obs;
	final RxString selectedStatus = 'All Orders'.obs;
	final Rx<DateTime?> startDate = Rx<DateTime?>(null);
	final Rx<DateTime?> endDate = Rx<DateTime?>(null);

	int _page = 1;
	final int _limit = 10;
	bool _hasMore = true;
	String _searchTerm = '';
	Timer? _searchDebounce;

	List<String> get statusOptions => <String>['All Orders', 'active', 'pause', 'missed', 'upcoming', 'delivered'];

	String get statusLabel => _capitalize(selectedStatus.value);

	String get dateRangeLabel {
		if (startDate.value == null || endDate.value == null) {
			return _formatDate(DateTime.now());
		}
		final DateTime start = startDate.value!;
		final DateTime end = endDate.value!;
		return '${_formatDate(start)}\n${_formatDate(end)}';
	}

	bool get showEmptyState => !isLoading.value && orders.isEmpty;

	bool get canLoadMore => _hasMore && !isLoading.value && !isLoadingMore.value;

	Future<void> getAllOrders({bool reset = false}) async {
		final String driverId = MySharedPref.getString(PreferenceKey.driverID) ?? '';
		if (driverId.isEmpty) {
			if (reset) {
				orders.clear();
			}
			return;
		}

		if (reset) {
			_page = 1;
			_hasMore = true;
			orders.clear();
		}

		if (!_hasMore) {
			return;
		}

		if (_page == 1) {
			isLoading.value = true;
		} else {
			isLoadingMore.value = true;
		}

		final String? statusQuery = selectedStatus.value == 'All Orders' ? null : selectedStatus.value.toLowerCase();

		final d.Response? response = await BaseService().get(
			ApiUrl.allOrders(
				driverId: driverId,
				page: _page,
				limit: _limit,
				search: _searchTerm.isEmpty ? null : _searchTerm,
				status: statusQuery,
				startDate: startDate.value,
				endDate: endDate.value,
			),
		);

		isLoading.value = false;
		isLoadingMore.value = false;

		if (response?.statusCode != 200 || response?.data == null) {
			_hasMore = false;
			if (response != null && response.statusCode != 200) {
				final BuildContext? context = Get.context;
				if (context != null) {
					CustomSnackBar.showToast(
						context,
						messages: response.data['message'] ?? 'Something went wrong',
					);
				}
			}
			return;
		}

		final AllOrdersModel fetched = AllOrdersModel.fromJson(response!.data as Map<String, dynamic>);
		allOrdersModel.value = fetched;

		final List<Datum> fetchedOrders = fetched.data?.data ?? <Datum>[];
		if (reset || _page == 1) {
			orders.assignAll(fetchedOrders);
		} else {
			orders.addAll(fetchedOrders);
		}

		final Pagination? pagination = fetched.data?.pagination;
		if (pagination != null) {
			final int current = pagination.currentPage ?? _page;
			final int totalPages = pagination.totalPages ?? current;
			_hasMore = current < totalPages;
		} else {
			_hasMore = fetchedOrders.length == _limit;
		}

		if (_hasMore) {
			_page += 1;
		}
	}

	void onSearchChanged(String value) {
		_searchTerm = value.trim();
		_searchDebounce?.cancel();
		_searchDebounce = Timer(const Duration(milliseconds: 400), () {
			getAllOrders(reset: true);
		});
	}

	void clearSearch() {
		_searchDebounce?.cancel();
		_searchTerm = '';
		getAllOrders(reset: true);
	}

	void selectStatus(String status) {
		selectedStatus.value = status;
		getAllOrders(reset: true);
	}

	void updateDateRange(DateTime? start, DateTime? end) {
		startDate.value = start;
		endDate.value = end;
		getAllOrders(reset: true);
	}

	void loadMoreOrders() {
		if (canLoadMore) {
			getAllOrders();
		}
	}

	String _formatDate(DateTime date) {
		return DateFormat('dd MMM yyyy').format(date);
	}

	String _capitalize(String value) {
		if (value.isEmpty) {
			return value;
		}
		return value[0].toUpperCase() + value.substring(1);
	}

	@override
	void onClose() {
		_searchDebounce?.cancel();
		super.onClose();
	}
}