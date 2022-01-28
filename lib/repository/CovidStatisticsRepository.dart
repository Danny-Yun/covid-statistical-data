import 'package:covid_statistical_data/model/CovidStatistics.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

class CovidStatisticsRepository {
  String covidUrl =
      "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?ServiceKey=FMdeBTwXrIXJqIqhl%2BnOMjEj0mKsTW9ao%2BIbQmICQRSlI5q9zGZEbC0Zr%2FyLp%2Fb5SYR7BaFe7yj9iqSD3a6uNw%3D%3D";

  late var _dio;
  var startDate = "";
  var endDate = "";

  CovidStatisticsRepository() {
    _dio = Dio();
  }

  Future<Covid19StatisticsModel> fetchCovid19Statistics() async {
    var response = await _dio.get(covidUrl);

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
