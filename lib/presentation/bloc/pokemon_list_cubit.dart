import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/domain/model/pokemon_list.dart';
import 'package:pokeapp/domain/repository/pokemon_repository.dart';
import 'package:pokeapp/presentation/bloc/pokemon_list_state.dart';

class PokemonListCubit extends Cubit<PokemonListState> {
  final PokemonRepository repository;

  PokemonListCubit({required this.repository})
      : super(PokemonListState(
          list: PokemonList(
            count: -1,
            next: null,
            previous: null,
            names: [],
          ),
          status: PokemonListStatus.init,
        ));

  void getListNext() async {
    Future<PokemonList> Function() func;
    PokemonListStatus newStatus;

    if (state.status == PokemonListStatus.init) {
      func = repository.getList;
      newStatus = PokemonListStatus.loading;
    } else {
      func = repository.getListNext;
      newStatus = PokemonListStatus.loadMore;
    }

    emit(PokemonListState(
      list: state.list,
      status: newStatus,
    ));

    try {
      PokemonList awaitedList = await func();
      emit(
        PokemonListState(
            list: PokemonList(
              count: awaitedList.count,
              next: awaitedList.next,
              previous: awaitedList.previous,
              names: state.list.names + awaitedList.names,
            ),
            status: PokemonListStatus.succesful),
      );
    } catch (e) {
      emit(PokemonListState(
        list: state.list,
        status: PokemonListStatus.failure,
      ));
    }
  }
}
