import 'package:covid_statistical_data/controller/CovidStatisticsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Situation extends StatelessWidget {
  const Situation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('코로나 일별 현황'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Obx(() {
          var info = CovidStatisticsController.to.covidStatistic.value;
          return Column(
            children: [
              infoWidget('기준일', info.stateDt ?? ''),
              infoWidget('기준시간', info.stateTime ?? ''),
              infoWidget('확진자 수', info.decideCnt ?? ''),
              infoWidget('사망자 수', info.deathCnt ?? ''),
              infoWidget('누적 검사 수', info.accExamCnt ?? ''),
              infoWidget('누적 확진률', info.accDefRate ?? ''),
            ],
          );
        }),
      ),
    );
  }

  Widget infoWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            '$title',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            ' : $value',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
