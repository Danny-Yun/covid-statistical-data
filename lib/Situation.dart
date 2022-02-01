import 'package:covid_statistical_data/controller/CovidStatisticsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var info = CovidStatisticsController.to.covidStatistic.value;

class Situation extends StatelessWidget {
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
      body: Stack(
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
            ),
          )
          // Obx(() {
          //   var info = CovidStatisticsController.to.covidStatistic.value;
          //   return Column(
          //     children: [
          //       infoWidget('기준일', info.stateDt ?? ''),
          //       infoWidget('기준시간', info.stateTime ?? ''),
          //       infoWidget('확진자 수', info.decideCnt ?? ''),
          //       infoWidget('사망자 수', info.deathCnt ?? ''),
          //       infoWidget('누적 검사 수', info.accExamCnt ?? ''),
          //       infoWidget('누적 확진률', info.accDefRate ?? ''),
          //     ],
          //   );
          // }),
        ],
      ),
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
            child: Text(
              '${info.stateTime} 기준',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14.5,
              ),
            ),
          ),
        ),
      ),
      // 4. 확진자 수
      Positioned(
        top: headerTopZone + 80,
        right: 25,
        child: Column(
          children: [
            Text(
              '확진자',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.arrow_drop_up_outlined,
                  size: 40,
                  color: Colors.red,
                ),
                Text(
                  '1,627',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 50,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              '${info.decideCnt}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
