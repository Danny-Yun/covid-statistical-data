import 'package:covid_statistical_data/model/CovidStatisticsModel.dart';
import 'package:covid_statistical_data/repository/CovidStatisticsRepository.dart';
import 'package:covid_statistical_data/utils/ArrowClipPath.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CovidStatisticsController extends GetxController {
  late CovidStatisticsRepository _covidStatisticsRepository;
  Rx<Covid19StatisticsModel> _todayData = Covid19StatisticsModel().obs;
  RxList<Covid19StatisticsModel> _weekDatas = <Covid19StatisticsModel>[].obs;
  double maxDecideValue = 0;
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _covidStatisticsRepository = CovidStatisticsRepository();
    fetchCovidState();
  }

  void fetchCovidState() async {
    loading.value = true;
    await Future.delayed(Duration(seconds: 2));

    var startDate = DateFormat('yyyyMMdd')
        .format(DateTime.now().subtract(Duration(days: 7)));
    // DateTime.now()를 통해 항상 endDate가 당일로 설정되도록
    var endDate = DateFormat('yyyyMMdd').format(DateTime.now());
    var result = await _covidStatisticsRepository.fetchCovid19Statistics(
        startDate: startDate, endDate: endDate);
    print(result.length);
    if (result.isNotEmpty) {
      for (var i = 0; i < result.length; i++) {
        if (i < result.length - 1) {
          result[i].updateCalcAboutYesterday(result[i + 1]);
          if (maxDecideValue < result[i].calcDecideCnt) {
            maxDecideValue = result[i].calcDecideCnt;
          }
        }
      }
      // .reversed를 통해 역순으로
      _weekDatas.addAll(result.sublist(0, result.length - 1).reversed);
      _todayData(_weekDatas.last);
    }
    loading.value = false;
  }

  Covid19StatisticsModel get todayData => _todayData.value;
  List<Covid19StatisticsModel> get weekData => _weekDatas.value;

  ArrowDirection calculateUpDown(double value) {
    if (value == 0) {
      return ArrowDirection.MIDDLE;
    } else if (value > 0) {
      return ArrowDirection.UP;
    } else {
      return ArrowDirection.DOWN;
    }
  }
}
