import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokeapp/domain/model/pokemon.dart';

class PokemonDetails extends StatelessWidget {
  const PokemonDetails({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Expanded(
            flex: 3,
            child: Card(
                child: CachedNetworkImage(
              imageUrl: pokemon.imagePath,
              errorWidget: (context, url, error) =>
                  const Text('image loading error'),
            ))),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${pokemon.name}'),
              Row(
                children: [
                  const Text('Type:'),
                  ...[
                    for (final e in pokemon.types)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text(e),
                        ),
                      )
                  ],
                ],
              ),
              Text('Height: ${pokemon.height} cm'),
              Text('Weight: ${pokemon.weight} kg'),
            ],
          ),
        ),
      ],
    );
  }
}
