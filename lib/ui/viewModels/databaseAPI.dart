import 'package:earthquake_map/core/models/earthquakeModel.dart';
import 'package:earthquake_map/core/services/sqlite.dart';
import 'package:get/get.dart';

class SavedListController extends GetxController {
  var eqList = RxList<EQModel>();

  addEarthquakes(EQModel model) {
    try {
      SQliteService().insertItem(model);
      eqList.add(model);
    } catch (e) {
      print(e.code);
    }
  }

  getEarthquakes() async {
    eqList.addAll(await SQliteService().getList());
  }

  deleteEarthquate(EQModel model) {
    SQliteService().deleteItem(model.id);
    eqList.clear();
    getEarthquakes();
  }
}
