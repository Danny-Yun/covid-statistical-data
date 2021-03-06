import 'package:covid_statistical_data/controller/CovidStatisticsController.dart';
import 'package:covid_statistical_data/utils/ArrowClipPath.dart';
import 'package:covid_statistical_data/utils/Data_utils.dart';
import 'package:flutter/material.dart';

class CovidStatisticViewer extends StatelessWidget {
  late final String title;
  late final double addedCount;
  late final ArrowDirection upDown;
  late final double totalCount;
  late final bool dense;
  late final Color titleColor;
  late final Color subValueColor;

  CovidStatisticViewer({
    required this.title,
    required this.addedCount,
    required this.upDown,
    required this.totalCount,
    this.dense = false,
    this.titleColor = const Color(0xff4c4e5d),
    this.subValueColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    var color = Colors.black;
    switch (upDown) {
      case ArrowDirection.UP:
        color = Colors.red;
        break;
      case ArrowDirection.DOWN:
        color = Color(0xff3749be);
        break;
      case ArrowDirection.MIDDLE:
        break;
    }
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: titleColor,
            fontSize: dense ? 14 : 18,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipPath(
              clipper: ArrowClipPath(direction: upDown),
              child: Container(
                width: dense ? 10 : 20,
                height: dense ? 10 : 20,
                color: color,
              ),
            ),
            SizedBox(width: 7),
            Text(
              DataUtils.numberFormat(addedCount),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: dense ? 25 : 40,
              ),
            ),
          ],
        ),
        SizedBox(height: 7),
        Text(
          DataUtils.numberFormat(totalCount),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: subValueColor,
            fontSize: dense ? 15 : 20,
          ),
        ),
      ],
    );
  }
}
