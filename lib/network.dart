import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/5_day_forecast.dart';
import 'models/accu_city.dart';
import 'models/current_weather.dart';
import 'package:flutterweather/utils/const.dart';

Future<http.Response> fetchData(String fullUrl) async {
  var response = await http.get(fullUrl);
  if (response.statusCode == 200)
    return response;
  else
    throw Exception('Failed to load data');
}

Future<CurrentWeather> fetchCurrentWeather(String fullCityName) async {
  final response = await http
      .get(OWM_WEATHER_URL + 'q=Craiova' + '&' + OWM_APPID + '&units=metric');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return CurrentWeather.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error. s
    throw Exception('Failed to load post');
  }
}

Future<The5Dayforecast> fetchWeatherForecast(String fullCityName) async {
final response = await http
      .get(OWM_FORECAST_5_3_URL + 'q=Craiova' + '&' + OWM_APPID + '&units=metric');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return The5Dayforecast.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error. s
    throw Exception('Failed to load post');
  }
}

Future<List<AccuCity>> fetchCitiesByName(String name) async {
  try {
    if (name.isNotEmpty) {
      final response =
          await http.get(ACCU_CITY_API + 'q=' + name + '&' + ACCU_APIKEY);

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON.
        return AccuCity.fromListJson(json.decode(response.body));
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Did not find anything');
      }
    }
    return [];
  } catch (e) {
    throw Exception('Did not find anything');
  }
}
