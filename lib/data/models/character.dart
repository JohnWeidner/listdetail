import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  Character({
    required this.image,
    required this.title,
    required this.description,
  });

  factory Character.empty() => Character(
        image: '',
        title: '',
        description: '',
      );

  factory Character.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CharacterFromJson(json);

  final String image;
  final String title;
  final String description;

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
