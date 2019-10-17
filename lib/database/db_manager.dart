import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';


CollectionReference citiesDB = Firestore.instance.collection('cities');

Future addToDb(Map<String, dynamic> city) async {
  try {
    var db = citiesDB;
    await db.add(city);
    Future.delayed(Duration(milliseconds: 500));
  } catch (e) {
    print(e);
  }
}

class SearchService {
  Future<QuerySnapshot> searchCityByName(String searchField) async {
    
    var temp = await Firestore.instance
        .collection('cities')
        .where('name', isGreaterThanOrEqualTo: searchField)
        .where('name', isLessThan:searchField+'z' )
        .limit(10)
        .getDocuments();
    print("searc - " + temp.documents.toString());
    return temp;
  }
}

Widget streamBuilder(Function buildItem) => StreamBuilder(
    stream: citiesDB.snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return const Text('....Loading');
      return ListView.builder(
        itemExtent: 80.0,
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) => buildItem(context,
            snapshot.data.documents[index], snapshot.data.documents.length),
      );
    });
