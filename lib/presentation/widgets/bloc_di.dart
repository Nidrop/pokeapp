import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/data/data_source/pokeapi_data_source.dart';
import 'package:pokeapp/data/repository/pokeapi_repository.dart';
import 'package:pokeapp/presentation/bloc/pokemon_details_cubit.dart';
import 'package:pokeapp/presentation/bloc/pokemon_list_cubit.dart';

class BlocDI extends StatelessWidget {
  const BlocDI({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PokeapiRepository(PokeapiDataSource(Dio())),
      child: BlocProvider(
        create: (context) =>
            PokemonListCubit(repository: context.read<PokeapiRepository>()),
        child: BlocProvider(
          create: (context) => PokemonDetailsCubit(
              repository: context.read<PokeapiRepository>()),
          child: child,
        ),
      ),
    );
  }
}
