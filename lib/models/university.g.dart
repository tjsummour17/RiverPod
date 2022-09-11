// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

University _$UniversityFromJson(Map<String, dynamic> json) => University(
      domains:
          (json['domains'] as List<dynamic>?)?.map((e) => e as String).toList(),
      alphaTwoCode: json['alphaTwoCode'] as String?,
      country: json['country'] as String?,
      webPages: (json['webPages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$UniversityToJson(University instance) =>
    <String, dynamic>{
      'domains': instance.domains,
      'alphaTwoCode': instance.alphaTwoCode,
      'country': instance.country,
      'webPages': instance.webPages,
      'name': instance.name,
    };
