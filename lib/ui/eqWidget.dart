import 'package:flutter/material.dart';

class EQItem extends StatelessWidget {
  const EQItem({
    Key key,
    @required this.context,
    @required this.value,
  }) : super(key: key);

  final BuildContext context;

  final Map<String, String> value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      height: 80,
      child: Card(
        color: Colors.orange[700],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                value['title'],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  value['magnitude'],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
