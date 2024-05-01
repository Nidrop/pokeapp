// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDto _$PokemonDtoFromJson(Map<String, dynamic> json) => PokemonDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      height: (json['height'] as num).toInt(),
      weight: (json['weight'] as num).toInt(),
      sprites:
          PokemonSpritesDto.fromJson(json['sprites'] as Map<String, dynamic>),
      types: (json['types'] as List<dynamic>)
          .map((e) => PokemonTypesDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PokemonDtoToJson(PokemonDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'height': instance.height,
      'weight': instance.weight,
      'sprites': instance.sprites.toJson(),
      'types': instance.types.map((e) => e.toJson()).toList(),
    };
