import 'package:dream_wall/models/photos.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page.g.dart';

@JsonSerializable()
class Page {
  @JsonKey(name: "page")
  int page;

  @JsonKey(name: "per_page")
  int perPage;

  @JsonKey(name: "photos")
  List<Photos> photos;

  @JsonKey(name: "next_page")
  String nextPage;

  Page();

  factory Page.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);

  Map<String, dynamic> toJson() => _$PageToJson(this);
}
