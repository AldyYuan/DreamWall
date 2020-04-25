// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pages _$PagesFromJson(Map<String, dynamic> json) {
  return Pages()
    ..page = json['page'] as int
    ..perPage = json['per_page'] as int
    ..photos = (json['photos'] as List)
        ?.map((e) =>
            e == null ? null : Photos.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nextPage = json['next_page'] as String;
}

Map<String, dynamic> _$PagesToJson(Pages instance) => <String, dynamic>{
      'page': instance.page,
      'per_page': instance.perPage,
      'photos': instance.photos,
      'next_page': instance.nextPage,
    };
