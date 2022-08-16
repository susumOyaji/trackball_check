import 'package:flutter/material.dart';
import 'PaintHistory.dart';

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
  //bool _trace = true;

  double relativeDx = 0;
  double relativeDy = 0;

  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
  }

  void _manageOnHover(PointerEvent e) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final referenceWidth = (screenWidth) / 2;
    final newRelativeDx = (e.position.dx - referenceWidth); // / referenceWidth;
    final referenceHeight = (screenHeight) / 2;
    final newRelativeDy =
        (referenceHeight - e.position.dy); // / referenceHeight;

    setState(() => x = newRelativeDx);

    setState(() => y = newRelativeDy);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: MouseRegion(
        cursor: SystemMouseCursors.click, //hand click cursor
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
        onEnter: (event) {
          _onPaintHover(event);
        },
        onHover: (event) {
          _manageOnHover(event);
          _onPaintHover(event);
          _onPaintUpdate(event);
        },
      ),
    );
  }

  void _onPaintHover(PointerEvent details) {
    widget.paintController._paintHistory
        .addPaint(_getGlobalToLocalPosition(details.localPosition));
    widget.paintController._notifyListeners();
  }

  void _onPaintUpdate(PointerEvent details) {
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

  void nontrace() {
    _paintHistory.endTrace();
    notifyListeners();
  }

  void ontrace() {
    _paintHistory.startPaint();

    notifyListeners();
  }

  void clear() {
    _paintHistory.endPaint();
    _paintHistory.clear();

    notifyListeners();
  }
}
