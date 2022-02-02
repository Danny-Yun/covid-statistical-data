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
      resutlNegCnt: XmlUtils.searchResultForString(xml, "resutlNegCnt"),
      seq: XmlUtils.searchResultForString(xml, "seq"),
      stateDt: XmlUtils.searchResultForString(xml, "stateDt") != ''
          ? DateTime.parse(XmlUtils.searchResultForString(xml, "stateDt"))
          : null,
      stateTime: XmlUtils.searchResultForString(xml, "stateTime"),
      updateDt: XmlUtils.searchResultForString(xml, "updateDt"),
    );
  }
}
