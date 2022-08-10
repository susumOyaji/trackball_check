import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ShortCut());
}

class MyIntent extends Intent {
  const MyIntent({required this.name});

  final String name;
}

class ShortCut extends StatelessWidget {
  const ShortCut({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Shortcuts(
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.control): MyIntent(name: "in"),
        },
        child: Actions(
          actions: {
            MyIntent: CallbackAction(onInvoke: (i) {
              print('Hello World!!!');
              return null;
            }),
          },
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Hello World',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
