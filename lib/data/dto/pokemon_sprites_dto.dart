// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'pokemon_sprites_dto.g.dart';

@JsonSerializable()
class PokemonSpritesDto {
  String front_default;

  PokemonSpritesDto({
    required this.front_default,
  });

  factory PokemonSpritesDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpritesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonSpritesDtoToJson(this);
}
