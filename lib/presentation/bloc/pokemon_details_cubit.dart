import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/domain/model/pokemon.dart';
import 'package:pokeapp/domain/repository/pokemon_repository.dart';

class PokemonDetailsCubit extends Cubit<Future<Pokemon>> {
  final PokemonRepository repository;

  PokemonDetailsCubit({required this.repository})
      : super(
          Future<Pokemon>(() => Pokemon(
                name: '',
                imagePath: '',
                height: 0,
                weight: 0,
                types: [],
              )),
        );

  void getPokemonDetails(String name) {
    emit(repository.getPokemon(name));
  }
}
