// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photos _$PhotosFromJson(Map<String, dynamic> json) {
  return Photos()
    ..id = (json['id'] as num)?.toDouble()
    ..width = (json['width'] as num)?.toDouble()
    ..height = (json['height'] as num)?.toDouble()
    ..url = json['url'] as String
    ..photographer = json['photographer'] as String
    ..photographerUrl = json['photographer_url'] as String
    ..photographerId = (json['photographer_id'] as num)?.toDouble()
    ..src = json['src'] == null
        ? null
        : Source.fromJson(json['src'] as Map<String, dynamic>)
    ..liked = json['liked'] as bool;
}

Map<String, dynamic> _$PhotosToJson(Photos instance) => <String, dynamic>{
      'id': instance.id,
      'width': instance.width,
      'height': instance.height,
      'url': instance.url,
      'photographer': instance.photographer,
      'photographer_url': instance.photographerUrl,
      'photographer_id': instance.photographerId,
      'src': instance.src,
      'liked': instance.liked,
    };
