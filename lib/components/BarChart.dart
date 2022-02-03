import 'package:covid_statistical_data/model/CovidStatisticsModel.dart';
import 'package:covid_statistical_data/utils/data_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CovidBarChart extends StatelessWidget {
  CovidBarChart({Key? key, required this.covidDatas, required this.maxY})
      : super(key: key);

  final List<Covid19StatisticsModel> covidDatas;
  final double maxY;

  @override
  Widget build(BuildContext context) {
    print('maxY - $maxY');
    int x = 0;
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: this.covidDatas.map<BarChartGroupData>((data) {
          return BarChartGroupData(
            x: x++,
            barRods: [
              BarChartRodData(
                  y: data.calcDecideCnt,
                  colors: [Colors.lightBlueAccent, Colors.greenAccent]),
            ],
            showingTooltipIndicators: [0],
          );
        }).toList(),
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY * 1.2,
        // 기본값으로 나와있는 그리드 삭제
        gridData: FlGridData(show: false),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.y.round().toString(),
              const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff7589a2),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          margin: 20,
          getTitles: (double value) {
            return DataUtils.simpleDayFormat(
                covidDatas[value.toInt()].stateDt!);
          },
        ),
        leftTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );
}
