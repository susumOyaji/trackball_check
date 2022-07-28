import 'package:flutter/material.dart';

class MyInheritedWidget extends InheritedWidget {
  final String message;
  // コンストラクタでメッセージと子Widgetを取る
  MyInheritedWidget({required this.message, required Widget child})
      : super(child: child);

  // O(1)でInheritedWidgetを返却
  static MyInheritedWidget of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()
          as MyInheritedWidget;

  //更新されたかどうかの判定ロジック
  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) =>
      oldWidget.message != message;
}
