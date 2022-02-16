class City {
  final int? id;
  final String? cityName;

  City({this.id, this.cityName});

  factory City.fromMap(Map<String, dynamic> json) => City(
        id: json['id'],
        cityName: json['cityName'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cityName': cityName,
    };
  }
}
