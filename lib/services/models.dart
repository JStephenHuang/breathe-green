import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable(explicitToJson: true)
class Components {
  double co;
  double no;
  double no2;
  double o3;
  double so2;
  double pm2_5;
  double pm10;
  double nh3;

  Components({
    required this.co,
    required this.no,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.nh3,
  });
  factory Components.fromJson(Map<String, dynamic> json) =>
      _$ComponentsFromJson(json);
  Components toJson() => _$ComponentsFromJson(this as Map<String, dynamic>);
}

@JsonSerializable()
class Main {
  int aqi;

  Main({required this.aqi});
  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);
  Main toJson() => _$MainFromJson(this as Map<String, dynamic>);
}

@JsonSerializable()
class Coord {
  double lat;
  double lon;

  Map<String, double> toMap() {
    return {"lat": lat, "lon": lon};
  }

  Coord({required this.lat, required this.lon});
  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);
  Coord toJson() => _$CoordFromJson(this as Map<String, dynamic>);
}

@JsonSerializable()
class MainInfo {
  int dt;
  Components components;
  Main main;

  MainInfo({required this.dt, required this.components, required this.main});

  factory MainInfo.fromJson(Map<String, dynamic> json) =>
      _$MainInfoFromJson(json);
  MainInfo toJson() => _$MainInfoFromJson(this as Map<String, dynamic>);
}

@JsonSerializable()
class AirQuality {
  Coord coord;
  List<MainInfo> list;

  AirQuality({required this.coord, required this.list});

  factory AirQuality.fromJson(Map<String, dynamic> json) =>
      _$AirQualityFromJson(json);
  AirQuality toJson() => _$AirQualityFromJson(this as Map<String, dynamic>);
}

@JsonSerializable()
class ImageObject {
  String path;
  String url;

  Map<String, String> toMap() {
    return {
      "path": path,
      "url": url,
    };
  }

  ImageObject({required this.path, required this.url});

  factory ImageObject.fromJson(Map<String, dynamic> json) =>
      _$ImageObjectFromJson(json);
  ImageObject toJson() => _$ImageObjectFromJson(this as Map<String, dynamic>);
}

@JsonSerializable()
class Tree {
  String id;
  Coord coord;
  ImageObject imageObject;
  String status;
  String treeOwner;
  String date;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "coord": coord.toMap(),
      "imageObject": imageObject.toMap(),
      "status": status,
      "treeOwner": treeOwner,
      "date": date
    };
  }

  Tree({
    required this.id,
    required this.coord,
    required this.imageObject,
    required this.status,
    required this.treeOwner,
    required this.date,
  });

  factory Tree.fromJson(Map<String, dynamic> json) => _$TreeFromJson(json);
  Tree toJson() => _$TreeFromJson(this as Map<String, dynamic>);
}

@JsonSerializable()
class Person {
  String uid;
  String name;
  String email;
  String avatar;
  int points;
  int dailyPinnedTreeCount;

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "avatar": avatar,
      "points": points,
      "dailyPinnedTreeCount": dailyPinnedTreeCount,
    };
  }

  Person({
    required this.uid,
    required this.name,
    required this.email,
    this.avatar = "lvl1",
    this.points = 0,
    this.dailyPinnedTreeCount = 0,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Person toJson() => _$PersonFromJson(this as Map<String, dynamic>);
}
