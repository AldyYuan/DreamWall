// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Page _$PageFromJson(Map<String, dynamic> json) {
  return Page()
    ..page = json['page'] as int
    ..perPage = json['per_page'] as int
    ..photos = (json['photos'] as List)
        ?.map((e) =>
            e == null ? null : Photos.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nextPage = json['next_page'] as String;
}

Map<String, dynamic> _$PageToJson(Page instance) => <String, dynamic>{
      'page': instance.page,
      'per_page': instance.perPage,
      'photos': instance.photos,
      'next_page': instance.nextPage,
    };
