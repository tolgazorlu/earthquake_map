import 'package:earthquake_map/core/constants/string_functions.dart';
import 'package:earthquake_map/core/models/earthquakeModel.dart';
import 'package:get/get.dart';

class EQController extends GetxController {
  var eqList = RxList<EQModel>();
  var filteredList = RxList<EQModel>();

  addEQ(List<EQModel> earthquakeModelList) {
    eqList.addAll(earthquakeModelList);
  }

  filterList(int value) {
    if (value == null) {
      filteredList.clear();
      filteredList.addAll(eqList);
    } else {
      filteredList.clear();
      eqList.forEach((element) {
        if (double.parse(
                StringFunctions().titleSpiltting(element.title)['magnitude']) >=
            value) {
          filteredList.add(element);
        }
      });
    }
  }
}
