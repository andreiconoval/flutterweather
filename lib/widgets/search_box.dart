import 'package:flutter/material.dart';

import 'package:flutterweather/models/city.dart';

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
