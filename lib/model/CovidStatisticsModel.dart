import 'package:covid_statistical_data/utils/Data_utils.dart';
import 'package:covid_statistical_data/utils/xml_utils.dart';
import 'package:xml/xml.dart';

class Covid19StatisticsModel {
  String? accDefRate;
  String? accExamCnt;
  String? accExamCompCnt;
  String? careCnt;
  String? clearCnt;
  String? createDt;
  String? deathCnt;
  String? decideCnt;
  String? examCnt;
  String? resutlNegCnt;
  String? seq;
  DateTime? stateDt;
  String? stateTime;
  String? updateDt;

  double calcDecideCnt = 0;
  double calcExamCnt = 0;
  double calcDeathCnt = 0;
  double calcClearCnt = 0;

  Covid19StatisticsModel({
    this.accDefRate,
    this.accExamCnt,
    this.accExamCompCnt,
    this.careCnt,
    this.clearCnt,
    this.createDt,
    this.deathCnt,
    this.decideCnt,
    this.examCnt,
    this.resutlNegCnt,
    this.seq,
    this.stateDt,
    this.stateTime,
    this.updateDt,
  });

  factory Covid19StatisticsModel.empty() {
    return Covid19StatisticsModel();
  }

  factory Covid19StatisticsModel.fromXml(XmlElement xml) {
    return Covid19StatisticsModel(
      accDefRate: XmlUtils.searchResultForString(xml, "accDefRate"),
      accExamCnt: XmlUtils.searchResultForString(xml, "accExamCnt"),
      accExamCompCnt: XmlUtils.searchResultForString(xml, "accExamCompCnt"),
      careCnt: XmlUtils.searchResultForString(xml, "careCnt"),
      clearCnt: XmlUtils.searchResultForString(xml, "clearCnt"),
      createDt: XmlUtils.searchResultForString(xml, "createDt"),
      deathCnt: XmlUtils.searchResultForString(xml, "deathCnt"),
      decideCnt: XmlUtils.searchResultForString(xml, "decideCnt"),
      examCnt: XmlUtils.searchResultForString(xml, "examCnt"),
      resutlNegCnt: XmlUtils.searchResultForString(xml, "resultNegCnt"),
      seq: XmlUtils.searchResultForString(xml, "seq"),
      stateDt: XmlUtils.searchResultForString(xml, "stateDt") != ''
          ? DateTime.parse(XmlUtils.searchResultForString(xml, "stateDt"))
          : null,
      stateTime: XmlUtils.searchResultForString(xml, "stateTime"),
      updateDt: XmlUtils.searchResultForString(xml, "updateDt"),
    );
  }

  void updateCalcAboutYesterday(Covid19StatisticsModel yesterdayData) {
    _updateCalcDecideCnt(yesterdayData.decideCnt!);
    // _updateCalcExamCnt(yesterdayData.examCnt!);
    _updateCalcDeathCnt(yesterdayData.deathCnt!);
    // _updateCalcClearCnt(yesterdayData.clearCnt!);
  }

  void _updateCalcDecideCnt(String beforeCnt) {
    calcDecideCnt = double.parse(decideCnt!) - double.parse(beforeCnt);
  }

  void _updateCalcExamCnt(String beforeCnt) {
    calcExamCnt = double.parse(examCnt!) - double.parse(beforeCnt);
  }

  void _updateCalcDeathCnt(String beforeCnt) {
    calcDeathCnt = double.parse(deathCnt!) - double.parse(beforeCnt);
  }

  void _updateCalcClearCnt(String beforeCnt) {
    calcClearCnt = double.parse(clearCnt!) - double.parse(beforeCnt);
  }

  String get standardDayString => stateDt == null
      ? ''
      : '${DataUtils.simpleDayFormat(stateDt)} $stateTime 기준';
}
