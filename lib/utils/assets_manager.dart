import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'const.dart';

///Load file from path and convert to string
Future<String> _loadAssetAsString(String path) async {
  try {
    return await rootBundle.loadString(path);
  } catch (e) {
    print('loadAssetAsString error for path:' + path);
    return '';
  }
}

///Convert String file to Map<String, dynamic>
List<Map<String, dynamic>> _parseJosn(String response) {
  if (response == null) {
    return [];
  }
  try {
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed;
  } catch (e) {
    print('parseJosn error:');
    return [];
  }
}

Future<List<Map<String, Object>>> getCities() async  {
  try {
    List<Map<String, dynamic>> cities = [];
     await _loadAssetAsString(CITIES_PATH)
        .then((value) => cities = _parseJosn(value));
    return cities;
  } catch (e) {
    print('getCities error:');
    return [];
  }
}
