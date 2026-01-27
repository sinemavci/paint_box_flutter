// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ColorDTO _$ColorDTOFromJson(Map<String, dynamic> json) => _ColorDTO(
  red: (json['red'] as num).toDouble(),
  green: (json['green'] as num).toDouble(),
  blue: (json['blue'] as num).toDouble(),
  alpha: (json['alpha'] as num?)?.toDouble(),
);

Map<String, dynamic> _$ColorDTOToJson(_ColorDTO instance) => <String, dynamic>{
  'red': instance.red,
  'green': instance.green,
  'blue': instance.blue,
  'alpha': instance.alpha,
};
