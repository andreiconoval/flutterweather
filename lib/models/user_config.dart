class UserConfig {
  String key;
  String value;
  DateTime lastChange;

  UserConfig({
    this.key,
    this.value,
    this.lastChange,
  });

  factory UserConfig.fromJson(Map<String, dynamic> json) => UserConfig(
        key: json['key'],
        value: json['value'],
        lastChange: DateTime.parse(json['lastChange']),
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
        'lastChange': lastChange.toIso8601String(),
      };
}
