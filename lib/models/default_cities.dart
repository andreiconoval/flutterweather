import 'package:flutterweather/models/city.dart';

class DefaultCities {
  City defaultCity;
  List<City> searchedCities;

  DefaultCities({this.defaultCity, this.searchedCities});

  // Convert Map<String,dynamic> to UserConfig
  DefaultCities fromJson(Map<String, dynamic> json) {
    var defaultCity =
        json['defaultCity'] != null ? City.fromJson(json['defaultCity']) : null;
    var searchedCities = json['searchedCities'] != null
        ? City().fromListJson(json['searchedCities'])
        : null;
    if (defaultCity == null && searchedCities == null) return null;

    return DefaultCities(defaultCity: defaultCity, searchedCities: searchedCities);
  }

  // Convert  UserConfig  to Map<String,dynamic>
  Map<String, dynamic> toJson() => {
        'defaultCity': defaultCity.toJson(),
        'searchedCities': searchedCities.map((f) => f.toJson()).toList(),
      };
}
