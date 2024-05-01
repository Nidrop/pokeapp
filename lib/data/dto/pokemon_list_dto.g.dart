// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonListDto _$PokemonListDtoFromJson(Map<String, dynamic> json) =>
    PokemonListDto(
      count: (json['count'] as num).toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>)
          .map((e) => PokemonListItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PokemonListDtoToJson(PokemonListDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results.map((e) => e.toJson()).toList(),
    };
