import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_api/providers/fetch_pokemon_provider.dart';

void main() {
  runApp(const ProviderScope(child: PokemonApp()));
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pokemons'),
        ),
        body: ref.watch(fetchPokemonProvider).maybeWhen(fetched: (pokemons) {
          return ListView(
            children: pokemons
                .map((e) => ListTile(
                      title: Text(e.name!),
                      leading: Image.network(
                        e.image!,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      subtitle: Text(e.classification!),
                    ))
                .toList(),
          );
        }, orElse: () {
          return Container();
        }));
  }
}
