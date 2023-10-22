// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Components _$ComponentsFromJson(Map<String, dynamic> json) => Components(
      co: (json['co'] as num).toDouble(),
      no: (json['no'] as num).toDouble(),
      no2: (json['no2'] as num).toDouble(),
      o3: (json['o3'] as num).toDouble(),
      so2: (json['so2'] as num).toDouble(),
      pm2_5: (json['pm2_5'] as num).toDouble(),
      pm10: (json['pm10'] as num).toDouble(),
      nh3: (json['nh3'] as num).toDouble(),
    );

Map<String, dynamic> _$ComponentsToJson(Components instance) =>
    <String, dynamic>{
      'co': instance.co,
      'no': instance.no,
      'no2': instance.no2,
      'o3': instance.o3,
      'so2': instance.so2,
      'pm2_5': instance.pm2_5,
      'pm10': instance.pm10,
      'nh3': instance.nh3,
    };

Main _$MainFromJson(Map<String, dynamic> json) => Main(
      aqi: json['aqi'] as int,
    );

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'aqi': instance.aqi,
    };

Coord _$CoordFromJson(Map<String, dynamic> json) => Coord(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );

Map<String, dynamic> _$CoordToJson(Coord instance) => <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
    };

MainInfo _$MainInfoFromJson(Map<String, dynamic> json) => MainInfo(
      dt: json['dt'] as int,
      components:
          Components.fromJson(json['components'] as Map<String, dynamic>),
      main: Main.fromJson(json['main'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MainInfoToJson(MainInfo instance) => <String, dynamic>{
      'dt': instance.dt,
      'components': instance.components,
      'main': instance.main,
    };

AirQuality _$AirQualityFromJson(Map<String, dynamic> json) => AirQuality(
      coord: Coord.fromJson(json['coord'] as Map<String, dynamic>),
      list: (json['list'] as List<dynamic>)
          .map((e) => MainInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AirQualityToJson(AirQuality instance) =>
    <String, dynamic>{
      'coord': instance.coord,
      'list': instance.list,
    };

ImageObject _$ImageObjectFromJson(Map<String, dynamic> json) => ImageObject(
      path: json['path'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$ImageObjectToJson(ImageObject instance) =>
    <String, dynamic>{
      'path': instance.path,
      'url': instance.url,
    };

Tree _$TreeFromJson(Map<String, dynamic> json) => Tree(
      id: json['id'] as String,
      coord: Coord.fromJson(json['coord'] as Map<String, dynamic>),
      imageObject:
          ImageObject.fromJson(json['imageObject'] as Map<String, dynamic>),
      status: json['status'] as String,
      treeOwner: json['treeOwner'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$TreeToJson(Tree instance) => <String, dynamic>{
      'id': instance.id,
      'coord': instance.coord,
      'imageObject': instance.imageObject,
      'status': instance.status,
      'treeOwner': instance.treeOwner,
      'date': instance.date,
    };

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String? ?? "lvl1",
      points: json['points'] as int? ?? 0,
      dailyPinnedTreeCount: json['dailyPinnedTreeCount'] as int? ?? 0,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
      'points': instance.points,
      'dailyPinnedTreeCount': instance.dailyPinnedTreeCount,
    };
