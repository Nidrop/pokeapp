// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_types_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonTypesDto _$PokemonTypesDtoFromJson(Map<String, dynamic> json) =>
    PokemonTypesDto(
      slot: (json['slot'] as num).toInt(),
      type: PokemonTypesTypeDto.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonTypesDtoToJson(PokemonTypesDto instance) =>
    <String, dynamic>{
      'slot': instance.slot,
      'type': instance.type.toJson(),
    };
