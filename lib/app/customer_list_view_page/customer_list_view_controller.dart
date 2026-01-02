import 'package:get/get.dart';

class CustomerListViewController extends GetxController {

  final List<String> filterOptions = <String>[
    'All Location',
    'Location',
    'Self Picked Up',
    'Doorstep',
  ];

  final RxString selectedFilter = 'All Location'.obs;

  void selectFilter(String option) {
    selectedFilter.value = option;
  }
}