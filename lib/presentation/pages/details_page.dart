import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/domain/model/pokemon.dart';
import 'package:pokeapp/presentation/bloc/pokemon_details_cubit.dart';
import 'package:pokeapp/presentation/widgets/pokemon_details.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonFuture = context.watch<PokemonDetailsCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon details'),
      ),
      body: FutureBuilder<Pokemon>(
        future: pokemonFuture,
        builder: (BuildContext context, AsyncSnapshot<Pokemon> snapshot) {
          if (snapshot.hasData) {
            return PokemonDetails(pokemon: snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
