import 'dart:html' as html;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trackball_check/PaintHistory.dart';
import 'Painter.dart';
import 'InheritedWidget.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Track Boll Check(Web) Ver0.0.0 ';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(),
      home: const MyStatefulWidget(
          //appBar: AppBar(title: const Text(_title)),
          //body: const MyStatefulWidget(),
          ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final SignController _controller = SignController();

// The node used to request the keyboard focus.
  final FocusNode _focusNode = FocusNode();
  bool _trace = false;
  bool _phase = true;
// The message to display.
//  String? _message;

  @override
  void initState() {
    super.initState();
    print("initState");
    _traceControl();
  }

// Focus nodes need to be disposed.
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _traceControl() {
    //if (_trace) {
    //  _controller.nontrace();
    //} else {
    //  _controller.ontrace();
    //}
    setState(() {
      _trace = !_trace;
    });
  }

  void toast() {
    Fluttertoast.showToast(
      msg: "Unsupported!",
      fontSize: 16.0,
      textColor: Colors.white,
      backgroundColor: Colors.black54,
      timeInSecForIosWeb: 2,
    );
  }

// Handles the key events from the RawKeyboardListener and update the
// _message.
  void _handleKeyEvent(KeyEvent event) {
    //F2 = 4294969346;
    // キーダウン
    //if (event.logicalKey == LogicalKeyboardKey.keyQ) {}
    if (event.logicalKey == LogicalKeyboardKey.findKeyByKeyId(49)) {
      //Digit 1
      print('KeyDown : ${event.logicalKey.debugName}');
      //11_traceControl();
      if (_trace) {
        _controller.nontrace();
      } else {
        _controller.ontrace();
      }
      setState(() {
        _trace = !_trace;
      });
    }
    if (event.logicalKey == LogicalKeyboardKey.findKeyByKeyId(50)) {
      //Digit 2
      print('KeyDown : ${event.logicalKey.debugName}');
      _controller.clear();
    }
    if (event.logicalKey == LogicalKeyboardKey.findKeyByKeyId(51)) {
      //Digit 3
      print('KeyDown : ${event.logicalKey.debugName}');
      setState(() {
        _phase = !_phase;
      });
    }

    if (event.logicalKey == LogicalKeyboardKey.findKeyByKeyId(52)) {
      //Digit 4
      print('KeyDown : ${event.logicalKey.debugName}');
      toast();
      //String myurl = Uri.base.toString(); //get complete url

      //var newLocation = window.location..href = myurl;

      //window.location = newLocation;
      // Does not close this window, as the history has changed.
      //window.close();
      //print(window.location);
      //print(window.closed); // 'false'
    }
    //if (event.logicalKey == LogicalKeyboardKey.findKeyByKeyId(4294969346)) {
    //F1key
    //  print('KeyDown : ${event.logicalKey.debugName}');
    //  _controller.clear();
    //}

    // キーアップ
    if (event is KeyUpEvent) {
      print('KeyUp : ${event.logicalKey.debugName}');
    }
    //setState(() {
    //  print(event.logicalKey.debugName);
    //});
  }

  @override
  Widget build(BuildContext context) {
    //final TextTheme textTheme = Theme.of(context).textTheme;
    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          _handleKeyEvent(event);
          //if (event.logicalKey == LogicalKeyboardKey.keyQ) {
          //  _controller.clear();
          //  print('KeyDown : ${event.logicalKey.debugName}');
          //処理
          //  return KeyEventResult.handled;
          //}
        }
        return KeyEventResult.ignored;
      },
      child: Scaffold(
        body: Signer(
          paintController: _controller,
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              //heroTag: "Trace",
              onPressed: () => _controller.nontrace(),
              child: const Text('1  Trace',
                  style: TextStyle(
                    color: Colors.black,
                  )),
              style: ElevatedButton.styleFrom(
                primary: _trace ? Colors.orangeAccent : Colors.grey,
              ),
            ),
            TextButton(
              //heroTag: "clear",
              onPressed: () => _controller.clear(),
              child: const Text('2  Clear',
                  style: TextStyle(
                    color: Colors.black,
                  )),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
            ),
            TextButton(
              //heroTag: "Phase/Pluse",
              onPressed: () => _controller.clear(),
              child: Text('3 ${_phase ? 'Phase' : 'Pluse'}',
                  style: TextStyle(
                    color: Colors.black,
                  )),
              style: ElevatedButton.styleFrom(
                primary: _phase ? Colors.orangeAccent : Colors.grey,
              ),
            ),
            ElevatedButton(
              //heroTag: "Phase/Pluse",
              onPressed: () => toast(),
              child: const Text('4  Quit(Close)',
                  style: TextStyle(
                    color: Colors.black,
                  )),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
