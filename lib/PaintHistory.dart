import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _PaintData {
  _PaintData({
    required this.path,
  }) : super();

  Path path;
}

class SignHistory {
  final List<MapEntry<_PaintData, Paint>> _paintList =
      <MapEntry<_PaintData, Paint>>[];

  // ペイントundoリスト
  final List<MapEntry<_PaintData, Paint>> _undoneList =
      <MapEntry<_PaintData, Paint>>[];

  final Paint _backgroundPaint = Paint();

  bool _inDrag = false;

  late Paint currentPaint;

  set backgroundColor(color) => _backgroundPaint.color = color;

  /*
   * undo可能か
   */
  bool canUndo() => _paintList.length > 0;

  /*
   * redo可能か
   */
  bool canRedo() => _undoneList.length > 0;

  /*
   * undo
   */
  void undo() {
    if (!_inDrag && canUndo()) {
      _undoneList.add(_paintList.removeLast());
    }
  }

  /*
   * redo
   */
  void redo() {
    if (!_inDrag && canRedo()) {
      _paintList.add(_undoneList.removeLast());
    }
  }

  void clear() {
    if (!_inDrag) {
      _paintList.clear();
    }
  }

  void addPaint(Offset startPoint) {
    if (!_inDrag) {
      _inDrag = true;
      Path path = Path();
      path.moveTo(startPoint.dx, startPoint.dy);
      _PaintData data = _PaintData(path: path);
      _paintList.add(MapEntry<_PaintData, Paint>(data, currentPaint));
    }
  }

  void updatePaint(Offset nextPoint) {
    if (_inDrag) {
      _PaintData data = _paintList.last.key;
      Path path = data.path;
      path.lineTo(nextPoint.dx, nextPoint.dy);
    }
  }

  void upmovePaint(Offset nextPoint) {
    if (_inDrag) {
      _PaintData data = _paintList.last.key;
      Path path = data.path;
      path.moveTo(nextPoint.dx, nextPoint.dy);
    }
  }

  void endPaint() {
    _inDrag = false;
  }

  void draw(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(
        0.0,
        0.0,
        size.width,
        size.height,
      ),
      _backgroundPaint,
    );

    for (MapEntry<_PaintData, Paint> data in _paintList) {
      canvas.drawPath(data.key.path, data.value);
    }
  }
}
