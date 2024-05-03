import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:paginated_list/paginated_list.dart';
import 'package:pokeapp/presentation/bloc/pokemon_details_cubit.dart';
import 'package:pokeapp/presentation/bloc/pokemon_list_cubit.dart';
import 'package:pokeapp/presentation/bloc/pokemon_list_state.dart';
import 'package:pokeapp/presentation/pages/details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final state = context.read<PokemonListCubit>().state;
    if (state.status == PokemonListStatus.init) {
      context.read<PokemonListCubit>().getListNext();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon list'),
        actions: kDebugMode
            ? [
                IconButton(
                  onPressed: () {
                    DefaultCacheManager().emptyCache();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('cache cleared')));
                  },
                  icon: const Icon(Icons.remove_circle),
                  tooltip: 'clear cache',
                ),
              ]
            : null,
      ),
      body: BlocBuilder<PokemonListCubit, PokemonListState>(
          builder: (BuildContext context, PokemonListState state) {
        if (state.status == PokemonListStatus.init) {
          return const Text('init state');
        }
        if (state.status == PokemonListStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == PokemonListStatus.failure) {
          return const Center(child: Text('smth went wrong'));
        }
        return PaginatedGrid<String>(
          loadingIndicator: const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          items: state.list.names,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.0,
          ),
          isLastPage: state.list.next == null,
          onLoadMore: () {
            context.read<PokemonListCubit>().getListNext();
          },
          builder: (name, index) => GestureDetector(
            onTap: () {
              context.read<PokemonDetailsCubit>().getPokemonDetails(name);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const DetailsPage()));
            },
            child: Card(
              child: Center(child: Text(name)),
            ),
          ),
        );
      }),
    );
  }
}
