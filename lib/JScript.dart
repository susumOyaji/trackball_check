import 'package:flutter/material.dart';

// lodash用に定義した処理を読み込む
import 'lodash.dart';

void main() {
  runApp(MyScript());
}

class MyScript extends StatelessWidget {
  const MyScript({Key? key}) : super(key: key);

  void _showConfirmButton() {
    confirm("Hello, this is a confirm");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body:
            //_showConfirmuButton;
            Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                // _.max() を呼び出す
                max([10, 20, 30]).toString(),
                style: TextStyle(fontSize: 24),
              ),
              Text(
                // _.camelCase() を呼び出す
                camelCase('Foo Bar'),
                style: TextStyle(fontSize: 24),
              ),
              Text(
                //heroTag: "clear",
                confirm('Foo Bar2'),
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
