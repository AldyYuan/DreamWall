import 'package:dream_wall/models/source.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photos.g.dart';

@JsonSerializable()
class Photos {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "width")
  int width;

  @JsonKey(name: "height")
  int height;

  @JsonKey(name: "url")
  String url;

  @JsonKey(name: "photographer")
  String photographer;

  @JsonKey(name: "photographer_url")
  String photographerUrl;

  @JsonKey(name: "photographer_id")
  String photographerId;

  @JsonKey(name: "src")
  Source src;

  @JsonKey(name: "liked")
  bool liked;

  Photos();

  factory Photos.fromJson(Map<String, dynamic> json) => _$PhotosFromJson(json);

  Map<String, dynamic> toJson() => _$PhotosToJson(this);
}
