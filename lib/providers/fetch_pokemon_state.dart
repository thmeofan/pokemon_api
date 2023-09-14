import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/pokemon.dart';
part 'fetch_pokemon_state.freezed.dart';

@freezed
class FetchPokemonState with _$FetchPokemonState {
  factory FetchPokemonState.initial() = _Initial;
  factory FetchPokemonState.fetching() = _Fetching;
  factory FetchPokemonState.fetched(List<Pokemon> pokemon) = _Fetched;
  factory FetchPokemonState.failed(String error) = _Failed;
}
