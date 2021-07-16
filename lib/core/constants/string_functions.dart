class StringFunctions {
  Map<String, String> titleSpiltting(String data) {
    String magnitude = '';
    String title = '';
    List<String> arr = data.split(" ");
    magnitude = arr[0];
    arr.removeAt(0);
    arr.removeAt(0);
    arr.removeLast();
    arr.removeLast();
    arr.forEach((item) {
      title = title + item + ' ';
    });

    return {'title': title, 'magnitude': magnitude};
  }

  Map<String, String> descripionToCoordinat(String data) {
    String x = '';
    String y = '';
    // double enlem, boylam;
    List<String> arr = data.split(" ");
    x = arr.elementAt(4);
    y = arr.elementAt(5);
    x = deltetPlus(x);
    y = deltetPlus(y);

    return {'x': x, 'y': y};
  }

  Map<String, String> pubDate(String data) {
    List<String> arr = data.split(" ");
    arr.removeLast;
    arr.removeLast;

    return {'gun': arr.first, 'tarih': arr[1] + ' ' + arr[2] + ' ' + arr[3]};
  }

  String deltetPlus(String data) {
    return data.replaceAll(r'+', '');
  }
}
