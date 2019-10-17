class Coord {
  final num lon;
  final num lat;
  Coord(this.lon, this.lat);

  Coord.fromJson(Map<String, dynamic> json)
      : lon = json['lon'] as num,
        lat = json['lat'] as num;

  Map<String, dynamic> toJson() => {
        'lon': lon,
        'lat': lat,
      };
}