// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterState _$CharacterStateFromJson(Map<String, dynamic> json) =>
    CharacterState(
      characters: (json['characters'] as List<dynamic>)
          .map((e) => Character.fromJson(e as Map<String, dynamic>))
          .toList(),
      filter: json['filter'] as String,
      loading: json['loading'] as bool,
      error: json['error'] as bool,
    );

Map<String, dynamic> _$CharacterStateToJson(CharacterState instance) =>
    <String, dynamic>{
      'characters': instance.characters,
      'filter': instance.filter,
      'loading': instance.loading,
      'error': instance.error,
    };
