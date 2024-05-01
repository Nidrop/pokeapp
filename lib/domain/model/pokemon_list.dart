class PokemonList {
  int count;
  String? next;
  String? previous;
  List<String> names;

  PokemonList({
    required this.count,
    required this.next,
    required this.previous,
    required this.names,
  });
}
