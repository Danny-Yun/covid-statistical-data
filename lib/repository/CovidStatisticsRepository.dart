import 'package:covid_statistical_data/model/CovidStatisticsModel.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

class CovidStatisticsRepository {
  String covidUrl =
      "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?ServiceKey=FMdeBTwXrIXJqIqhl%2BnOMjEj0mKsTW9ao%2BIbQmICQRSlI5q9zGZEbC0Zr%2FyLp%2Fb5SYR7BaFe7yj9iqSD3a6uNw%3D%3D";

  late var dio = Dio();
  var startDate = "";
  var endDate = "";
  var query = Map<String, String>();

  CovidStatisticsRepository() {
    dio = Dio();
  }

  Future<Covid19StatisticsModel> fetchCovid19Statistics(
      {String? startDate, String? endDate}) async {
    if (startDate != null) query.putIfAbsent("startCreateDt", () => startDate);
    if (endDate != null) query.putIfAbsent("endCreateDt", () => endDate);

    var response = await dio.get(covidUrl, queryParameters: query);
    final document = XmlDocument.parse(response.data);
    final result = document.findAllElements('item');
    var covid19Statics = <Covid19StatisticsModel>[];

    if (result.isNotEmpty) {
      return Covid19StatisticsModel.fromXml(result.first);
    } else {
      return Future.value(null);
    }

    // items.map((node) => node.text).forEach(print);
    // result.forEach((node) {
    //   covid19Statics.add(Covid19StatisticsModel.fromXml(node));
    // });
  }
}
