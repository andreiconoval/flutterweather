import 'dart:ui';

class ColorPallete {
  /// Color constants
  static const Color _sunRiseTopColor = const Color.fromARGB(255, 151, 81, 213);
  static const Color _sunRiseBottomColor =
      const Color.fromARGB(230, 252, 220, 119);

  static const Color _sunTopColor = const Color.fromARGB(255, 54, 104, 227);
  static const Color _sunBottomColor = const Color.fromARGB(230, 251, 247, 119);

  
  static const Color _sunSetTopColor = const Color.fromARGB(255, 54, 35, 153);
  static const Color _sunSetBottomColor = const Color.fromARGB(230, 68, 181, 249);

/// Get sky colors depending on current time
  static List<Color> getSkyColors() {
    var time = DateTime.now();
    if (time.hour < 11 && time.hour > 7) return [_sunRiseTopColor,_sunRiseBottomColor];
    else if (time.hour > 20 && time.hour < 7) return [_sunSetTopColor,_sunSetBottomColor];

    return [_sunTopColor,_sunBottomColor];
  }
}
