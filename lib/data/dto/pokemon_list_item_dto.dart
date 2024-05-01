import 'package:json_annotation/json_annotation.dart';

part 'pokemon_list_item_dto.g.dart';

@JsonSerializable()
class PokemonListItemDto {
  String name;
  String url;

  PokemonListItemDto({
    required this.name,
    required this.url,
  });

  factory PokemonListItemDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonListItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonListItemDtoToJson(this);
}
