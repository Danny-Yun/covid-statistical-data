import 'package:covid_statistical_data/model/CovidStatisticsModel.dart';
import 'package:covid_statistical_data/repository/CovidStatisticsRepository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CovidStatisticsController extends GetxController {
  static CovidStatisticsController get to => Get.find();

  late CovidStatisticsRepository _covidStatisticsRepository;
  Rx<Covid19StatisticsModel> _todayData = Covid19StatisticsModel().obs;
  RxList<Covid19StatisticsModel> _weekDates = <Covid19StatisticsModel>[].obs;
  double maxDecideValue = 0;

  @override
  void onInit() {
    super.onInit();
    _covidStatisticsRepository = CovidStatisticsRepository();
    fetchCovidState();
  }

  void fetchCovidState() async {
    var startDate = DateFormat('yyyyMMdd')
        .format(DateTime.now().subtract(Duration(days: 7)));
    var endDate = DateFormat('yyyyMMdd').format(DateTime.now());
    var result = await _covidStatisticsRepository.fetchCovid19Statistics(
        startDate: startDate, endDate: endDate);
  }

  Covid19StatisticsModel get todayData => _todayData.value;
  List<Covid19StatisticsModel> get weekData => _weekDates.value;
}
