//JavaScript 関数の呼び出し

// 利用するJavaScriptのクラスを宣言
@JS('_')
library lodash;

import 'package:js/js.dart';

// Calls invoke JavaScript `JSON.lodash(obj)`.
// 利用するクラスに紐づくメソッド名を宣言し、I/Fを定義
//externalを付けた関数を定義して、@JS("JS側の関数名")を付けます。
@JS('max')
external int max(List<int> array);

// 他のメソッドも同じく
@JS('camelCase')
external String camelCase(String string);

@JS('confirm')
external confirm(String text);

// Calls invoke JavaScript `JSON.stringify(obj)`.
@JS('JSON.stringify')
external String stringify(Object obj);
