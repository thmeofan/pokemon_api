import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_api/providers/fetch_pokemon_state.dart';

import '../models/pokemon.dart';

final fetchPokemonProvider =
    StateNotifierProvider<FetchPokemonProvider, FetchPokemonState>((ref) =>
        FetchPokemonProvider(FetchPokemonState.initial())..fetchPokemons());

class FetchPokemonProvider extends StateNotifier<FetchPokemonState> {
  FetchPokemonProvider(super.state);
  fetchPokemons() async {
    state = FetchPokemonState.fetching();
    try {
      Dio dio = Dio();
      var response =
          await dio.post('https://graphql-pokemon2.vercel.app/', data: {
        "query": r'''
              query {
                pokemons(first: 50){
                id
                name
                classification
                image
              }
            }
               '''
      });
      List<dynamic> responseData = response.data['data']['pokemons'];
      state = FetchPokemonState.fetched(
          responseData.map((e) => Pokemon.fromJson(e)).toList());
    } on DioException catch (e) {
      state = FetchPokemonState.failed(e.message!);
    } catch (e) {
      state = FetchPokemonState.failed('Failed to catch pokemons');
    }
  }
}
