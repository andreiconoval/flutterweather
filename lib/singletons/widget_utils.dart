import 'package:flutter/material.dart';

class WidgetUtils {
  MediaQueryData _mediaQueryData;
  double _screenWidth;
  double _screenHeight;
  double _blockSizeHorizontal;
  double _blockSizeVertical;

  MediaQueryData get mediaQueryData => _mediaQueryData;
  double get screenWidth => _screenWidth;
  double get screenHeight => _screenHeight;
  double get blockSizeHorizontal => _blockSizeHorizontal;
  double get blockSizeVertical => _blockSizeVertical;

  WidgetUtils._internal();

  static final WidgetUtils _widgetUtils = WidgetUtils._internal();

  factory WidgetUtils() {
    return _widgetUtils;
  }

  init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;
  }
}
