import 'dart:async';

import 'package:earthquake_map/core/constants/string_functions.dart';
import 'package:earthquake_map/core/models/earthquakeModel.dart';
import 'package:earthquake_map/ui/viewModels/databaseAPI.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailPage extends StatefulWidget {
  final EQModel earthquake_model;

  const DetailPage({Key key, this.earthquake_model}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final savedListController = Get.find<SavedListController>();
  double enlem = 0, boylam = 0;
  EQModel myModel;
  CameraPosition _kLake;

  @override
  Widget build(BuildContext context) {
    enlem = double.parse(StringFunctions()
        .descripionToCoordinat(widget.earthquake_model.description)['x']);
    boylam = double.parse(StringFunctions()
        .descripionToCoordinat(widget.earthquake_model.description)['y']);
    Completer<GoogleMapController> _controller = Completer();
    Marker marker = Marker(
        markerId: MarkerId("marker1"),
        draggable: false,
        position: LatLng(enlem, boylam));
    _kLake = CameraPosition(
        bearing: 0, target: LatLng(enlem, boylam), tilt: 0, zoom: 6);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBoddy(marker, _controller),
    );
  }

  Widget _buildBoddy(
      Marker marker, Completer<GoogleMapController> _controller) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Expanded(
            flex: 40,
            child: _buildMaps(marker, _controller),
          ),
          Expanded(
            flex: 20,
            child: _buildDetailList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailList() {
    return Container(
      margin: EdgeInsets.all(2),
      child: Column(
        children: [
          Expanded(
            child: ListTile(
              title: Text("EARTHQUAKE:",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text(widget.earthquake_model.title),
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text("Date : ",
                  style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              subtitle: Text(widget.earthquake_model.pubDate),
            ),
          ),
          Expanded(
              child: InkWell(
                  onTap: _saveModel,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orangeAccent),
                    alignment: Alignment.center,
                    child: Text(
                      'Save this map',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  )))
        ],
      ),
    );
  }

  void _saveModel() async {
    savedListController.addEarthquakes(widget.earthquake_model);
  }

  Widget _buildMaps(Marker marker, Completer<GoogleMapController> _controller) {
    return Container(
      margin: EdgeInsets.all(5),
      child: GoogleMap(
        markers: Set.from([marker]),
        mapType: MapType.terrain,
        initialCameraPosition: _kLake,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.blue,
      title: Text(
        "Details",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
