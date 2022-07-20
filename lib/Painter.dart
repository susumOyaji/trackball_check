import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'PaintHistory.dart';
//import 'package:flutter/services.dart';

class Signer extends StatefulWidget {
  final SignController paintController;

  Signer({required this.paintController})
      : super(key: ValueKey<SignController>(paintController));

  @override
  _SignerState createState() => _SignerState();
}

class _SignerState extends State<Signer> {
  double x = 0.0;
  double y = 0.0;

  void _updateLocation(PointerEvent details) {
    //Text(
    //    style: TextStyle(color: Colors.white),
    //    'The cursor is here: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})');
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      //child: Builder(
      //builder: (BuildContext context) {

      //final FocusNode focusNode = Focus.of(context);
      //final bool hasFocus = focusNode.hasFocus;
      child: MouseRegion(
        cursor: SystemMouseCursors.text, //hand click cursor
        child: CustomPaint(
          willChange: true,
          painter: _CustomPainter(
            widget.paintController._paintHistory,
            repaint: widget.paintController,
          ),
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      style: TextStyle(color: Colors.white),
                      'The cursor is here: (X: ${x.toStringAsFixed(0)}, Y: ${y.toStringAsFixed(0)})'),
                ]),
          ),
        ),
        onHover: (event) {
          _onPaintHover(event);
          _onPaintUpdateM(event);
          // _onPaintExd(event);
          _updateLocation(event);
        },
      ),
      // },
      //),
      //width: double.infinity,
      //height: double.infinity,
    );
  }

  void _onPaintHover(PointerEvent details) {
    widget.paintController._paintHistory
        .addPaint(_getGlobalToLocalPosition(details.localPosition));
    widget.paintController._notifyListeners();
  }

  void _onPaintUpdateM(PointerEvent details) {
    widget.paintController._paintHistory
        .updatePaint(_getGlobalToLocalPosition(details.localPosition));
    widget.paintController._notifyListeners();
  }

  Offset _getGlobalToLocalPosition(Offset global) {
    return (context.findRenderObject() as RenderBox).globalToLocal(global);
  }
}

//線を描写するクラス（_CustomPainter）を保持
class _CustomPainter extends CustomPainter {
  final SignHistory _paintHistory;

  _CustomPainter(this._paintHistory, {required Listenable repaint})
      : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    _paintHistory.draw(canvas, size);
  }

  @override
  bool shouldRepaint(_CustomPainter oldDelegate) => true;
}

class SignController extends ChangeNotifier {
  final SignHistory _paintHistory = SignHistory();

  final Color _drawColor = Colors.orangeAccent;

  final double _thickness = 2.0;

  final Color _backgroundColor = Colors.black;

  SignController() : super() {
    Paint paint = Paint();
    paint.color = _drawColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = _thickness;
    _paintHistory.currentPaint = paint;
    _paintHistory.backgroundColor = _backgroundColor;
  }

  void _notifyListeners() {
    notifyListeners();
  }

  void clear() {
    _paintHistory.endPaint();
    _paintHistory.clear();
    //2_paintHistory.addPaint(Offset(280, 639));
    notifyListeners();
  }
}
