import 'package:covid_statistical_data/components/BarChart.dart';
import 'package:covid_statistical_data/components/CovidStatisticViewer.dart';
import 'package:covid_statistical_data/controller/CovidStatisticsController.dart';
import 'package:covid_statistical_data/utils/Data_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Situation extends GetView<CovidStatisticsController> {
  Situation({Key? key}) : super(key: key);
  double headerTopZone = 0;

  @override
  Widget build(BuildContext context) {
    // Getx의 미디어쿼리를 적용해서 각 디바이스에 알맞게끔, 공통적으로 앱바 아래서부터 시작하도록
    headerTopZone = Get.mediaQuery.padding.top + AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('코로나 일별 현황'),
        centerTitle: true,
        elevation: 0,
        // 배경을 투명색으로
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.menu),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(Icons.notifications),
          ),
        ],
      ),
      // body 영역을 앱바 뒤로 확장
      extendBodyBehindAppBar: true,
      body: Obx(() {
        if (controller.loading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Stack(
            children: [
              ..._background(),
              // 5. 흰색 배경
              Positioned(
                top: headerTopZone + 220,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _todayStatistics(),
                          SizedBox(height: 30),
                          _covidTrendsChart(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }
      }),
    );
  }

  List<Widget> _background() {
    return [
      // 1. 배경 컨테이너
      Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                Colors.blueGrey,
                Colors.teal,
              ]),
        ),
      ),
      // 2. 이미지
      Positioned(
        left: -30,
        top: headerTopZone + 50,
        child: Image.asset(
          'assets/virus.png',
          // 이미지의 크기를 비율로 정할 수도 있음
          width: Get.size.width * 0.5,
        ),
      ),
      // 3. 기준일
      Positioned(
        top: headerTopZone + 10,
        left: 0,
        right: 0,
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.3),
            ),
            child: Obx(
              () => Text(
                controller.todayData.standardDayString,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14.5,
                ),
              ),
            ),
          ),
        ),
      ),
      // 4. 확진자 수
      Positioned(
        top: headerTopZone + 80,
        right: 25,
        child: Obx(
          () => CovidStatisticViewer(
            title: '확진자',
            addedCount: controller.todayData.calcDecideCnt,
            totalCount: DataUtils.simpleFormatStringToDouble(
                controller.todayData.decideCnt),
            titleColor: Colors.white,
            subValueColor: Colors.white,
            upDown:
                controller.calculateUpDown(controller.todayData.calcDecideCnt),
          ),
        ),
      ),
    ];
  }

  Widget _todayStatistics() {
    return Obx(
      () => Row(
        children: [
          // 격리해제 인원
          Expanded(
            child: CovidStatisticViewer(
              title: '격리해제',
              addedCount: 3072,
              totalCount: 765245,
              upDown:
                  controller.calculateUpDown(controller.todayData.calcClearCnt),
              dense: true,
            ),
          ),
          VerticalDivider(),
          // 검사 중인 인원
          Expanded(
            child: CovidStatisticViewer(
              title: '검사 중',
              addedCount: 33314,
              totalCount: 1274367,
              upDown:
                  controller.calculateUpDown(controller.todayData.calcExamCnt),
              dense: true,
            ),
          ),
          VerticalDivider(),
          // 사망 인원
          Expanded(
            child: CovidStatisticViewer(
              title: '사망자',
              addedCount: controller.todayData.calcDeathCnt,
              totalCount: 6812,
              upDown:
                  controller.calculateUpDown(controller.todayData.calcDeathCnt),
              dense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _covidTrendsChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '확진자 추이',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        AspectRatio(
          aspectRatio: 1.1,
          child: Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: Obx(
              () => controller.weekData.length == 0
                  ? Container()
                  : CovidBarChart(
                      covidDatas: controller.weekData,
                      maxY: controller.maxDecideValue),
            ),
          ),
        ),
      ],
    );
  }

  Widget verticalDivider() {
    return Container(
      height: 60,
      child: VerticalDivider(
        color: Colors.grey.withOpacity(0.5),
      ),
    );
  }
}
