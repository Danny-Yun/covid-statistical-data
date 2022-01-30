import 'package:covid_statistical_data/Situation.dart';
import 'package:covid_statistical_data/binding/CovidStatisticsControllerBinding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'The current status of COVID-19',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Situation(),
      initialBinding: CovidStatisticsControllerBinding(),
    );
  }
}
