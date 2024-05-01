import 'package:json_annotation/json_annotation.dart';
import 'package:pokeapp/data/dto/pokemon_list_item_dto.dart';

part 'pokemon_list_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class PokemonListDto {
  int count;
  String? next;
  String? previous;
  List<PokemonListItemDto> results;

  PokemonListDto({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PokemonListDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonListDtoToJson(this);
}
