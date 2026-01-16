import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:milkshop_driver/app/order_detail_page/order_detail_page.dart';
import 'package:milkshop_driver/common/common_textfield.dart';

import '../../common/common_flex.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import 'order_page_controller.dart';
import 'order_page_model.dart';


class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late final OrderPageController _controller;
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(OrderPageController());
    _searchController = TextEditingController();
    _scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getAllOrders(reset: true);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    if (Get.isRegistered<OrderPageController>()) {
      Get.delete<OrderPageController>();
    }
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double current = _scrollController.position.pixels;
    if (current >= maxScroll - 80) {
      _controller.loadMoreOrders();
    }
  }

  Future<void> _pickDateRange() async {
    final DateTime now = DateTime.now();
    final DateTime start = _controller.startDate.value ?? now.subtract(const Duration(days: 7));
    final DateTime end = _controller.endDate.value ?? now;
    final DateTimeRange initialRange = DateTimeRange(start: start, end: end);
    final DateTimeRange? range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      initialDateRange: _controller.startDate.value != null && _controller.endDate.value != null ? initialRange : null,
      builder: (BuildContext context, Widget? child) {
        if (child == null) {
          return const SizedBox.shrink();
        }
        final ThemeData theme = Theme.of(context);
        return Theme(
          data: theme.copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primaryColor,
              onPrimary: AppColor.whiteColor,
              onSurface: AppColor.blackColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.primaryColor,
              ),
            ),
          ),
          child: child,
        );
      },
    );
    if (range != null) {
      _controller.updateDateRange(range.start, range.end);
    }
  }

  void _clearDateRange() {
    if (_controller.startDate.value != null || _controller.endDate.value != null) {
      _controller.updateDateRange(null, null);
    }
  }

  void _clearSearch() {
    if (_searchController.text.isEmpty) {
      return;
    }
    _searchController.clear();
    _controller.clearSearch();
  }

  String _prettyStatus(String value) {
    if (value.isEmpty) {
      return value;
    }
    return value[0].toUpperCase() + value.substring(1);
  }

  void _openStatusSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColor.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Status filter', style: AppTextStyle.medium20(AppColor.blackColor)),
                    spacer(),
                    GestureDetector(
                      onTap: Get.back,
                      child: Image.asset('assets/images/close.png', height: 20.h, width: 20.h),
                    ),
                  ],
                ),
                h(24),
                Obx(() {
                  final List<String> options = _controller.statusOptions;
                  return Column(
                    children: options.map((String option) {
                      final bool isSelected = _controller.selectedStatus.value == option;
                      final String label = option == 'All' ? 'All statuses' : _prettyStatus(option);
                      return InkWell(
                        onTap: () {
                          _controller.selectStatus(option);
                          Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  label,
                                  style: AppTextStyle.regular17(AppColor.blackColor),
                                ),
                              ),
                              if (isSelected)
                                Icon(Icons.check, color: AppColor.primaryColor, size: 20.w),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColor.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 20.h),
              child: Row(
                children: [
                  Text('Orders',style: AppTextStyle.medium20(AppColor.whiteColor),),
                  spacer(),
                  Image.asset('assets/images/notification.png',height: 20.h,width: 20.h,),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 16.h),
              child: Obx(() {
                final bool hasDate = _controller.startDate.value != null && _controller.endDate.value != null;
                return Row(
                  children: [
                    GestureDetector(
                      onTap: _pickDateRange,
                      child: Row(
                        children: [
                          Text(
                            _controller.dateRangeLabel,
                            style: AppTextStyle.bold14(AppColor.blackColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),   w(8),
                          Image.asset('assets/images/calender.png',height: 20.h,width: 20.h,color: AppColor.blackAccentColor,),
                          w(8),
                          if (hasDate)
                            IconButton(
                              onPressed: _clearDateRange,
                              icon: Icon(Icons.close, size: 18.w, color: AppColor.greyColor),
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                        ],
                      ),
                    ),
                spacer(),
                    GestureDetector(
                      onTap: _openStatusSheet,
                      child: Row(
                        children: [
                          Text(
                            _controller.statusLabel,
                            style: AppTextStyle.bold14(AppColor.blackColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          w(12),
                          Image.asset('assets/images/filter.png',height: 20.h,width: 20.h,),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomTextInput(
                fillColor: AppColor.whiteColor,
                filled: true,
                textEditController: _searchController,
                hintTextString: 'Search by customer name, order id...',
                borderColor: AppColor.greyColor,
                prefixIcon: Icon(Icons.search,color: AppColor.greyColor,),
                suffixIcon: IconButton(
                  onPressed: _clearSearch,
                  icon: Icon(Icons.close, color: AppColor.greyColor, size: 20.w),
                ),
                onChanged: _controller.onSearchChanged,
              ),
            ),
            h(10),
            Expanded(
              child: Obx(() {
                if (_controller.isLoading.value && _controller.orders.isEmpty) {
                  return const Center(child: CircularProgressIndicator(color: AppColor.primaryColor));
                }
                if (_controller.showEmptyState) {
                  return Center(
                    child: Text(
                      'No orders found',
                      style: AppTextStyle.regular16(AppColor.blackAccentColor),
                    ),
                  );
                }
                final int itemCount = _controller.orders.length + (_controller.isLoadingMore.value ? 1 : 0);
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: itemCount,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= _controller.orders.length) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: const Center(child:CircularProgressIndicator(color: AppColor.primaryColor)),
                      );
                    }
                    final Datum order = _controller.orders[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: _OrderCard(order),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard(this.order);

  final Datum order;

  @override
  Widget build(BuildContext context) {
    final String orderId = order.orderNumber ?? '-';
    final String customer = order.name?.trim().isNotEmpty == true
        ? order.name!
        : (order.userId?.fullName ?? 'Customer');
    final String qty = order.liter != null ? '${order.liter} ltr' : '-';
    final String amount = order.price != null ? '₹${order.price}' : '-';
    final String status = order.status?.isNotEmpty == true ? order.status! : 'unknown';
    final Color badgeColor = _statusColor(status);
    final DateTime? orderDate = order.orderDate;
    final String dateLabel = orderDate != null
        ? DateFormat('dd MMM yyyy').format(orderDate.toLocal())
        : '-';

    return InkWell(
      onTap: () {
        Get.to(()=>const OrderDetailPage(),arguments: order);
      },
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFEFEFE),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F1FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset('assets/images/milk_image.png'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "#$orderId",
                            style: AppTextStyle.medium12(AppColor.blackAccentColor),
                          ),
                          spacer(),
                          Text(
                            dateLabel,
                            style: AppTextStyle.medium12(AppColor.blackAccentColor),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: badgeColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        customer,
                        style: AppTextStyle.bold16(AppColor.blackColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _OrderMetric(title: 'Qty', value: qty),
                      const SizedBox(width: 24),
                      _OrderMetric(title: 'Amount', value: amount),
                      const SizedBox(width: 24),
                      _OrderMetric(title: 'Status', value: _formatStatus(status)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AppColor.grey50;
      case 'pause':
      case 'paused':
        return AppColor.yellowColor;
      case 'missed':
        return AppColor.redColor;
      case 'upcoming':
        return  AppColor.blueColor;
      case 'delivered':
        return AppColor.greenColor;
      default:
        return AppColor.greyColor;
    }
  }

  String _formatStatus(String value) {
    if (value.isEmpty) {
      return value;
    }
    return value[0].toUpperCase() + value.substring(1);
  }

}

class _OrderMetric extends StatelessWidget {
  const _OrderMetric({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: AppTextStyle.medium14(AppColor.blackAccentColor),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyle.medium16(AppColor.blackColor),
        ),
      ],
    );
  }
}
