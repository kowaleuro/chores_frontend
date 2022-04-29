import 'package:json_annotation/json_annotation.dart';

import 'Chore.dart';

part 'Place.g.dart';

@JsonSerializable()
class Place {
  Place(this.placeName,this.created,this.placeImageLink,this.placeId,this.chores);

  late int? placeId;
  late final String placeName;
  late DateTime? created;
  late String? placeImageLink;
  late List<Chore>? chores;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceToJson(this);


  // factory  Place.fromJson(Map<String, dynamic> json)
  //   : placeName = json['placeName'],
  //   created = json['created'],
  //   placeImageLink = json['placeImageLink'],
  //   placeId = json['placeId'];
  //
  //   // if (json['chores'] != null) {
  //   //   chores = [];
  //   //   json['chores'].forEach((v) {
  //   //     chores?.add(Chore.fromJson(v));
  //   //   });
  //   // }
  //
  //
  // Map<String, dynamic> toJson() => {
  //   'placeId': placeId,
  //   'placeName': placeName,
  //   'placeImageLink': placeImageLink
  // };

}