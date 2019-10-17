class AccuCity {
  num version;
  String key;
  String type;
  num rank;
  String localizedName;
  AdministrativeArea country;
  AdministrativeArea administrativeArea;

  AccuCity({
    this.version,
    this.key,
    this.type,
    this.rank,
    this.localizedName,
    this.country,
    this.administrativeArea,
  });

  AccuCity.fromJson(Map<String, dynamic> json)
      : version = json['Version'] as num,
        key = json['Key'],
        type = json['Type'],
        rank = json['Tank'] as num,
        localizedName = json['LocalizedName'];
        // country = AdministrativeArea.fromJson(json['country']),
        // administrativeArea =
        //     AdministrativeArea.fromJson(json['administrativeArea']);

  Map<String, dynamic> toJson() => {'localizedName': localizedName};

  static List<AccuCity> fromListJson(List<dynamic> jsons) {
    List<AccuCity> accuCities = [];

    try {
      for (var i = 0; i < jsons.length; i++)
      accuCities.add(AccuCity.fromJson(jsons[i]));
    } catch (e) {}
    
    return accuCities;
  }
}

class AdministrativeArea {
  String id;
  String localizedName;

  AdministrativeArea({
    this.id,
    this.localizedName,
  });

  AdministrativeArea.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        localizedName = json['localizedName'];
}
