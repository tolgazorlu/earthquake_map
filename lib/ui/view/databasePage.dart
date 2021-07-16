import 'package:earthquake_map/ui/viewModels/databaseAPI.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedListPage extends StatelessWidget {
  final savedListController = Get.find<SavedListController>();

  @override
  Widget build(BuildContext context) {
    //  savedListController.getDeprems();
    return Scaffold(
      backgroundColor: Color(0xff0000B4),
      appBar: _buildAppBar(),
      body: Obx(() => ListView.builder(
            itemCount: savedListController.eqList.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(2),
                child: ListTile(
                  title: Text(savedListController.eqList[index].title),
                ),
              );
            },
          )),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xff0000B4),
      title: Text(
        "Earthquakes",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
