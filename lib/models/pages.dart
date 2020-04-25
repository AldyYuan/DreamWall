import 'package:dream_wall/models/photos.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pages.g.dart';

@JsonSerializable()
class Pages {
  @JsonKey(name: "page")
  int page;

  @JsonKey(name: "per_page")
  int perPage;

  @JsonKey(name: "photos")
  List<Photos> photos;

  @JsonKey(name: "next_page")
  String nextPage;

  Pages();

  factory Pages.fromJson(Map<String, dynamic> json) => _$PagesFromJson(json);

  Map<String, dynamic> toJson() => _$PagesToJson(this);
}
