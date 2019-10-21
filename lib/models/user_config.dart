import 'package:flutterweather/models/city.dart';

class UserConfig {
  City defaultCity;
  List<City> searchedCities;

  UserConfig fromJson(Map<String, dynamic> json) {
    UserConfig userConfig = UserConfig();
    var defaultCity =
        json['defaultCity'] != null ? City.fromJson(json['defaultCity']) : null;
    var searchedCities =
        json['searchedCities'] != null ? City().fromListJson(json['searchedCities']) : null;
    if (defaultCity == null && searchedCities == null) return null;

    userConfig.defaultCity = defaultCity;
    userConfig.searchedCities = searchedCities;

    return userConfig;
  }
}
