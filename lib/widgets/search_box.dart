import 'package:flutter/material.dart';

import 'package:flutterweather/models/city.dart';
import 'package:flutterweather/network.dart';
import 'package:flutterweather/utils/assets_manager.dart';

class DataSearch extends SearchDelegate<String> {
  List<City> cities = [];
  List<String> suggestionCities = [];
  String selectedCity;

  _initiateListSearch() {
    final rawCities = getCities();
    print(rawCities);
    rawCities.then((c) => c.forEach((json) => cities.add(City.fromJson(json))));
  }

  _search(String query) {
    try {
      if (cities.isNotEmpty) {
        suggestionCities = query.isNotEmpty
            ? cities
                .where(
                    (c) => c.name.toLowerCase().contains(query.toLowerCase()))
                .map((val) => val.name)
                .toList()
            : cities.map((val) => val.name).toList();
      }
    } catch (e) {
      print('error' + e.toString());
    }
  }

  Future<List<String>> _webSearch(String query) async {
    try {
      List<String> list = [];
      var fetchedCities = await fetchCitiesByName(query);
      if (fetchedCities.isNotEmpty)
        list = fetchedCities.map((c) => c.localizedName + "/" + c.key).toList();
      return list;
      //.then((c) => c.forEach((f) => suggestionCities.add(f.localizedName)));
    } catch (e) {
      print('error' + e.toString());
      return [];
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
    return Container(
      height: 100,
      width: 100,
      child: Card(
        color: Colors.red,
        child: Center(child: Text(selectedCity)),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (cities.isEmpty) _initiateListSearch();

    _search(query);

    // Show some searches matching something
    return ListView.builder(
      itemBuilder: (context, index) =>
          _buildListItem(context, suggestionCities[index]),
      itemCount: suggestionCities.length,
    );
  }

  Widget _buildListItem(BuildContext context, String city) {
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
              city,
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffddddff),
            ),
            padding: EdgeInsets.all(10.0),
            child: Text(
              "meteo",
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ],
      ),
    );
  }
}
