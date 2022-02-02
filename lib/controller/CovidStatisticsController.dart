import 'package:covid_statistical_data/model/CovidStatisticsModel.dart';
import 'package:covid_statistical_data/repository/CovidStatisticsRepository.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CovidStatisticsController extends GetxController {
  static CovidStatisticsController get to => Get.find();

  late CovidStatisticsRepository _covidStatisticsRepository;
  Rx<Covid19StatisticsModel> covidStatistic = Covid19StatisticsModel().obs;

  @override
  void onInit() {
    super.onInit();
    _covidStatisticsRepository = CovidStatisticsRepository();
    fetchCovidState();
  }

  void fetchCovidState() async {
    var result = await _covidStatisticsRepository.fetchCovid19Statistics();
    if (result != null) {
      covidStatistic(result);
    }
  }
}
