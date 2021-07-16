import 'dart:async';
import 'dart:ui';

import 'package:earthquake_map/core/services/fetchData.dart';
import 'package:earthquake_map/ui/view/eqListPage.dart';
import 'package:earthquake_map/ui/viewModels/eqAdd.dart';
import 'package:earthquake_map/ui/viewModels/databaseAPI.dart';
import 'package:earthquake_map/ui/viewModels/eqAdd.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class getData extends StatefulWidget {
  @override
  _getDataState createState() => _getDataState();
}

class _getDataState extends State<getData> {
  final EQController depremController = Get.put(EQController());
  final SavedListController savedListController =
      Get.put(SavedListController());
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  @override
  void initState() {
    super.initState();
    getEathquake();
    startTimer();
  }

  Timer _timer;
  int _start = 2;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
          gotolistPage();
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future<void> getEathquake() async {
    var result = await APIservice().getAPI();
    savedListController.getEarthquakes();
    depremController.addEQ(result);
  }

  void gotolistPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => ListPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        children: [
          Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 1,
            child: Center(
                child: Text(
              "TURKEY EARTHQUAKES",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            )),
          ),
          Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
