import 'package:flutter/material.dart';
//import 'package:js/js.dart';
import 'dart:js' as js;

// lodash用に定義した処理を読み込む
import 'lodash.dart';

void main() {
  runApp(MyScript());
}

class MyScript extends StatelessWidget {
  const MyScript({Key? key}) : super(key: key);

  void _incrementCounter() {
    var state = js.JsObject.fromBrowserObject(js.context['state']);
    print(state['hello']);
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
            children: <Widget>[],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _incrementCounter();
            js.context
                .callMethod('jsTestFunction', ['DartからJavascriptを呼び出しました！']);
            js.context.callMethod('logger', ['_someFlutterState']);
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
