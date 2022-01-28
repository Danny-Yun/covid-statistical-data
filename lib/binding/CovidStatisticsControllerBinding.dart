import 'package:covid_statistical_data/controller/CovidStatisticsController.dart';
import 'package:get/instance_manager.dart';

class CovidStatisticsControllerBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(CovidStatisticsController());
  }
}
