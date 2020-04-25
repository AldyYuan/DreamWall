import 'package:json_annotation/json_annotation.dart';

part 'source.g.dart';

@JsonSerializable()
class Source {
  @JsonKey(name: "original")
  String original;

  @JsonKey(name: "large2x")
  String large2X;

  @JsonKey(name: "large")
  String large;

  @JsonKey(name: "medium")
  String medium;

  @JsonKey(name: "small")
  String small;

  @JsonKey(name: "potrait")
  String potrait;

  @JsonKey(name: "landscape")
  String landscape;

  @JsonKey(name: "tiny")
  String tiny;

  Source();

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
