import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:listdetail/model/character.dart';

part 'character_state.g.dart';

@JsonSerializable()
class CharacterState extends Equatable {
  const CharacterState({
    required this.characters,
    required this.filter,
    required this.loading,
  }) : super();

  factory CharacterState.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CharacterStateFromJson(json);

  factory CharacterState.initial() => const CharacterState(
        characters: [],
        filter: '',
        loading: false,
      );

  final List<Character> characters;
  final String filter;
  final bool loading;

  CharacterState copyWith({
    Character? currentCharacter,
    List<Character>? characters,
    String? filter,
    bool? loading,
  }) =>
      CharacterState(
        characters: characters ?? this.characters,
        filter: filter ?? this.filter,
        loading: loading ?? this.loading,
      );

  Map<String, dynamic> toJson() => _$CharacterStateToJson(this);

  List<Character> get filteredCharacters {
    if (filter.isEmpty) {
      return characters;
    }
    final searchString = filter.toUpperCase();
    return characters.where((c) => c.title.toUpperCase().contains(searchString) || c.description.toUpperCase().contains(searchString)).toList();
  }

  @override
  List<Object?> get props => [
        characters,
        loading,
        filter,
      ];
}
