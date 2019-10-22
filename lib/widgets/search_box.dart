import 'package:flutter/material.dart';

import 'package:flutterweather/models/city.dart';
import 'package:flutterweather/network.dart';
import 'package:flutterweather/widgets/wf_future.dart';

import 'cw_future.dart';

class DataSearch extends SearchDelegate<String> {
  List<City> cities = [];
  List<String> suggestionCities = [];
  String selectedCity;

  DataSearch({this.cities});

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

  Future webSearch(String query) async {
    try {
      if (query.length >= 2) {
        var searchedCities = await fetchCitiesByName(query);
        suggestionCities = searchedCities
            .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
            .map((val) => val.name)
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
              "Set default",
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ],
      ),
    );
  }
}
