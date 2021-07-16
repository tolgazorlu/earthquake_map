import 'dart:convert';

import 'package:earthquake_map/core/models/earthquakeModel.dart';
import 'package:xml2json/xml2json.dart';
import 'package:xml_parser/xml_parser.dart';

class APIservice {
  Future<List<EQModel>> getAPI() async {
    XmlDocument doc =
        await XmlDocument.fromUri('http://koeri.boun.edu.tr/rss/');
    var xml = doc.children[2];

    var xmlstr = xml.toString();
    final Xml2Json xml2Json = Xml2Json();
    xml2Json.parse(xmlstr);
    var jsonString = xml2Json.toParker();
    var data = jsonDecode(jsonString);
    var itemList = data['rss']['channel']['item'];
    List<EQModel> list = [];

    var item = itemList[0];
    print(item);
    EQModel tempModel;
    for (var item in itemList) {
      tempModel = EQModel.fromJson(item);
      list.add(tempModel);
    }

    return list;
  }
}
