import 'package:earthquake_map/core/constants/string_functions.dart';
import 'package:earthquake_map/core/services/fetchData.dart';
import 'package:earthquake_map/ui/view/mapPage.dart';
import 'package:earthquake_map/ui/view/databasePage.dart';
import 'package:earthquake_map/ui/viewModels/eqAdd.dart';
import 'package:earthquake_map/ui/eqWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _ListPageState extends State<ListPage> {
  String _valueChoose = null;
  List listItem = [
    'All Magnitude',
    '2',
    '3',
    '4',
    '5',
  ];

  final EQController earthquake = Get.find<EQController>();
  @override
  void initState() {
    earthquake.filterList(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var test = earthquake.eqList.length;
    print("list page, list size : " + test.toString());
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(flex: 15, child: _buildList()),
      ],
    );
  }

  DropdownButton<String> _buildBopdown() {
    return DropdownButton(
      hint: Text(
        "Magnitude",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            fontStyle: FontStyle.italic),
      ),
      dropdownColor: Color(0xff000000),
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      iconSize: 40,
      value: _valueChoose,
      onChanged: (newValue) {
        setState(() {
          _valueChoose = newValue;
        });
        earthquake.filterList(int.parse(_valueChoose));
      },
      items: listItem.map((valueitem) {
        return DropdownMenuItem(
          value: valueitem.toString(),
          child: Text(valueitem,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        );
      }).toList(),
    );
  }

  Widget _buildAppBar() {
    return PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: AppBar(
            actions: [
              IconButton(
                  onPressed: refreshPage,
                  icon: Icon(Icons.refresh, size: 35, color: Colors.white)),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SavedListPage(),
                    ));
                  },
                  icon: Icon(Icons.app_registration_rounded,
                      size: 35, color: Colors.white)),
            ],
            backgroundColor: Color(0xff0000FF),
            shape: RoundedRectangleBorder(),
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      _buildBopdown(),
                    ],
                  ),
                ),
              ],
            )));
  }

  Widget _buildList() {
    return Obx(() => ListView.builder(
          itemCount: earthquake.filteredList.length,
          itemBuilder: (context, index) {
            var model = earthquake.filteredList[index];

            var value = StringFunctions().titleSpiltting(model.title);

            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailPage(
                    earthquake_model: earthquake.filteredList[index],
                  ),
                ));
              },
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: EQItem(context: context, value: value)),
            );
          },
        ));
  }

  Future<void> refreshPage() async {
    var result = await APIservice().getAPI();
    earthquake.addEQ(result);
  }
}
