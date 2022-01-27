// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:xml/xml.dart';

// 데이터 파싱(Data Parsing)하면서 사전에 미리 테스트
void main() {
  final bookshelfXml =
      '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<response>
    <header>
        <resultCode>00</resultCode>
        <resultMsg>NORMAL SERVICE.</resultMsg>
    </header>
    <body>
        <items>
            <item>
                <accDefRate>1.522850408</accDefRate>
                <accExamCnt>4569802</accExamCnt>
                <createDt>2021-01-07 00:00:00.000</createDt>
                <deathCnt>1046</deathCnt>
                <decideCnt>66671</decideCnt>
                <seq>354</seq>
                <stateDt>20210107</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-10-07 10:30:51.51</updateDt>
            </item>
            <item>
                <accDefRate>1.525745123</accDefRate>
                <accExamCnt>4504860</accExamCnt>
                <createDt>2021-01-06 00:00:00.000</createDt>
                <deathCnt>1027</deathCnt>
                <decideCnt>65802</decideCnt>
                <seq>353</seq>
                <stateDt>20210106</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-10-07 10:30:51.51</updateDt>
            </item>
            <item>
                <accDefRate>1.530147779</accDefRate>
                <accExamCnt>4439354</accExamCnt>
                <createDt>2021-01-05 00:00:00.000</createDt>
                <deathCnt>1007</deathCnt>
                <decideCnt>64964</decideCnt>
                <seq>352</seq>
                <stateDt>20210105</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-10-07 10:30:51.51</updateDt>
            </item>
            <item>
                <accDefRate>1.534925834</accDefRate>
                <accExamCnt>4376602</accExamCnt>
                <createDt>2021-01-04 00:00:00.000</createDt>
                <deathCnt>981</deathCnt>
                <decideCnt>64250</decideCnt>
                <seq>351</seq>
                <stateDt>20210104</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-10-07 10:30:51.51</updateDt>
            </item>
            <item>
                <accDefRate>1.522015425</accDefRate>
                <accExamCnt>4340832</accExamCnt>
                <createDt>2021-01-03 00:00:00.000</createDt>
                <deathCnt>962</deathCnt>
                <decideCnt>63230</decideCnt>
                <seq>350</seq>
                <stateDt>20210103</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-10-07 10:30:51.51</updateDt>
            </item>
            <item>
                <accDefRate>1.517507982</accDefRate>
                <accExamCnt>4302792</accExamCnt>
                <createDt>2021-01-02 00:00:00.000</createDt>
                <deathCnt>942</deathCnt>
                <decideCnt>62573</decideCnt>
                <seq>349</seq>
                <stateDt>20210102</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-10-07 10:30:51.51</updateDt>
            </item>
            <item>
                <accDefRate>1.508973374</accDefRate>
                <accExamCnt>4269312</accExamCnt>
                <createDt>2021-01-01 00:00:00.000</createDt>
                <deathCnt>917</deathCnt>
                <decideCnt>61753</decideCnt>
                <seq>348</seq>
                <stateDt>20210101</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-10-07 10:30:51.51</updateDt>
            </item>
        </items>
        <numOfRows>10</numOfRows>
        <pageNo>1</pageNo>
        <totalCount>7</totalCount>
    </body>
</response>''';

  test('코로나 전체 통계', () {
    final document = XmlDocument.parse(bookshelfXml);
    final items = document.findAllElements('item');
    var covid19Statics = <Covid19StatisticsModel>[];

    // items.map((node) => node.text).forEach(print);
    items.forEach((node) {
      covid19Statics.add(Covid19StatisticsModel.fromXml(node));
    });
    covid19Statics.forEach((covid19) {
      print('${covid19.stateDt} : ${covid19.decideCnt}');
    });
  });
}

class Covid19StatisticsModel {
  String? accDefRate;
  String? accExamCnt;
  String? createDt;
  String? deathCnt;
  String? decideCnt;
  String? seq;
  String? stateDt;
  String? stateTime;
  String? updateDt;

  Covid19StatisticsModel({
    this.accDefRate,
    this.accExamCnt,
    this.createDt,
    this.deathCnt,
    this.decideCnt,
    this.seq,
    this.stateDt,
    this.stateTime,
    this.updateDt,
  });

  factory Covid19StatisticsModel.fromXml(XmlElement xml) {
    return Covid19StatisticsModel(
      accDefRate: XmlUtils.searchResult(xml, 'accDefRate'),
      accExamCnt: XmlUtils.searchResult(xml, 'accExamCnt'),
      createDt: XmlUtils.searchResult(xml, 'createDt'),
      deathCnt: XmlUtils.searchResult(xml, 'deathCnt'),
      decideCnt: XmlUtils.searchResult(xml, 'decideCnt'),
      seq: XmlUtils.searchResult(xml, 'seq'),
      stateDt: XmlUtils.searchResult(xml, 'stateDt'),
      stateTime: XmlUtils.searchResult(xml, 'stateTime'),
      updateDt: XmlUtils.searchResult(xml, 'updateDt'),
    );
  }
}

class XmlUtils {
  static String searchResult(XmlElement xml, String key) {
    return xml.findAllElements(key).map((e) => e.text).isEmpty
        ? ""
        : xml.findAllElements(key).map((e) => e.text).first;
  }
}
