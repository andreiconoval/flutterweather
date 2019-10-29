import 'package:flutter/material.dart';
import 'package:flutterweather/database/db_provider.dart';

import 'package:flutterweather/models/city.dart';
import 'package:flutterweather/models/default_cities.dart';
import 'package:flutterweather/network.dart';
import 'package:flutterweather/widgets/wf_future.dart';

import 'cw_future.dart';

class DataSearch extends SearchDelegate<String> {
  List<City> cities = [];
  List<City> suggestionCities = [];
  City selectedCity;

  DataSearch({this.cities});

  _search(String query) {
    try {
      if (cities.isNotEmpty) {
        suggestionCities = query.isNotEmpty
            ? cities
                .where(
                    (c) => c.name.toLowerCase().contains(query.toLowerCase()))
                .toList()
            : cities.toList();
      }
    } catch (e) {
      print('error' + e.toString());
    }
  }

  Future webSearch(String query) async {
    try {
      if (query.length >= 2) {
        var searchedCities = await fetchCitiesByName(query);
        suggestionCities = searchedCities
            .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    } catch (e) {
      print('error');
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading  icon on the left of app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Some result based on selection
    if (selectedCity == null) return Text('Fatality');
    return Column(children: [
      Container(child: getCWFutureBuilder(selectedCity)),
      Expanded(child: getWFutureBuilder(selectedCity)),
      //ContentScroll(),
    ]);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _search(query);

    if (query.length > 2) {
      webSearch(query);

      return FutureBuilder(
          future: webSearch(query),
          builder: (context, snapshot) {
            return ListView.builder(
              itemBuilder: (context, index) =>
                  _buildListItem(context, suggestionCities[index]),
              itemCount: suggestionCities.length,
            );
          });
    }
    return ListView.builder(
      itemBuilder: (context, index) =>
          _buildListItem(context, suggestionCities[index]),
      itemCount: suggestionCities.length,
    );
  }

  Widget _buildListItem(BuildContext context, City city) {
    if (city == null) return Text('nothing');
    return ListTile(
      onTap: () {
        showResults(context);
        selectedCity = city;
      },
      leading: Icon(Icons.location_city),
      title: Row(
        children: [
          Expanded(
            child: Text(
              city.name,
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () {
              setDefCity(city, context);
            },
            child: Text(
              'Set Default',
              style: TextStyle(fontSize: 20.0),
            ),
          )
        ],
      ),
    );
  }

  setDefCity(City city, BuildContext context) async {
    var oldDefCities = await DBProvier.db.getDefaultCities();
    oldDefCities = oldDefCities == null ? DefaultCities(): oldDefCities;
    if (oldDefCities.defaultCity == null ||
        oldDefCities.searchedCities == null) {
      oldDefCities.defaultCity = city;
      oldDefCities.searchedCities = [];
      oldDefCities.searchedCities.add(city);
    } else {
      oldDefCities.searchedCities.insert(0, city);
      oldDefCities.defaultCity = city;
      if (oldDefCities.searchedCities.length == 6)
        oldDefCities.searchedCities.removeLast();
    }

    await DBProvier.db.addOrUpdateDefaultCities(oldDefCities);
    close(context, null);
  }
}
