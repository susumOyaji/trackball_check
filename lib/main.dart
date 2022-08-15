import 'dart:html' as html;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'PaintHistory.dart';
import 'Painter.dart';
//import 'InheritedWidget.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'Nav2App.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'CopyableTextField.dart';
//import 'ShortCur.dart';
//import 'Invork.dart';
//import 'JScript.dart';
import 'dart:js' as js;
//import 'urlmain.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Track Ball Check(Web) Ver0.0.0 ';

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
  bool _clear = true;
  bool _phase = true;
// The message to display.
//  String? _message;

  @override
  void initState() {
    super.initState();
    _traceControl();
  }

// Focus nodes need to be disposed.
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _traceControl() {
    setState(() {
      _trace = !_trace;
    });
  }

  void _incrementCounter() {
    var state = js.JsObject.fromBrowserObject(js.context['state']);
    print(state['hello']);
  }

  void CloseTop() {
    js.context.callMethod('jsTestFunction', ['DartからJavascriptを呼び出しました！']);
    js.context.callMethod('logger', ['_someFlutterState']);
  }

// Handles the key events from the RawKeyboardListener and update the
// _message.
  void _handleKeyEvent(KeyEvent event) {
    //F2 = 4294969346;
    // キーダウン
    if (event.logicalKey == LogicalKeyboardKey.findKeyByKeyId(49)) {
      //Digit 1
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
      _controller.clear();
    }
    if (event.logicalKey == LogicalKeyboardKey.findKeyByKeyId(51)) {
      //Digit 3
      setState(() {
        _phase = !_phase;
      });
    }

    if (event.logicalKey == LogicalKeyboardKey.findKeyByKeyId(57)) {
      //Digit 9
      CloseTop();
    }
    //if (event.logicalKey == LogicalKeyboardKey.findKeyByKeyId(4294969346)) {
    //F1key
    print('KeyDown : ${event.logicalKey.debugName}');
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
            TextButton.icon(
              onPressed: () => _controller.nontrace(),
              label: Text('1  Trace',
                  style: TextStyle(
                    color: Colors.black,
                  )),
              icon: Icon(Icons.trending_up),
              style: ElevatedButton.styleFrom(
                primary: _trace ? Colors.orangeAccent : Colors.grey,
              ),
            ),
            TextButton.icon(
              onPressed: () => _controller.clear(),
              label: const Text('2  Clear',
                  style: TextStyle(
                    color: Colors.black,
                  )),
              icon: Icon(Icons.cleaning_services),
              style: ElevatedButton.styleFrom(
                primary: _clear ? Colors.orangeAccent : Colors.grey,
              ),
            ),
            TextButton(
              onPressed: () => _controller.clear(),
              child: Text('3 ${_phase ? 'Phase' : 'Pluse'}',
                  style: TextStyle(
                    color: Colors.black,
                  )),
              style: ElevatedButton.styleFrom(
                primary: _phase ? Colors.orangeAccent : Colors.grey,
              ),
            ),
            TextButton.icon(
              onPressed: () => CloseTop(),
              label: const Text('9  Quit(Close)',
                  style: TextStyle(
                    color: Colors.black,
                  )),
              icon: Icon(
                Icons.logout_outlined,
                color: Colors.orangeAccent,
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
