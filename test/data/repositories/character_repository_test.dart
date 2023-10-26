import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:listdetail/data/net_services/http_get.dart';
import 'package:listdetail/data/repositories/character_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockCharacterGetter extends Mock implements HttpGet {}

void main() {
  group('character repository tests', () {
    late HttpGet characterGetter;

    setUp(() {
      characterGetter = MockCharacterGetter();
    });

    test('can construct repo', () {
      try {
        CharacterRepository(characterGetter: characterGetter);
      } catch (e) {
        fail('unexpected exception constructing repo');
      }
    });

    test('if page is not found an exception gets thrown', () async {
      when(() => characterGetter.get()).thenAnswer((_) async => Response('', 404));
      try {
        final repo = CharacterRepository(characterGetter: characterGetter);
        await repo.fetchCharacters();
        fail('fetching characters should have thrown an exception when getting a 404 response');
      } catch (e) {
        expect(e, isInstanceOf<Exception>());
      }
    });

    test('if request does not return a json object then an exception gets thrown', () async {
      when(() => characterGetter.get()).thenAnswer((_) async => Response('success', 200));
      try {
        final repo = CharacterRepository(characterGetter: characterGetter);
        await repo.fetchCharacters();
        fail('fetching characters should have thrown an exception when the request does not return a json response');
      } catch (e) {
        expect(e, isInstanceOf<Exception>());
      }
    });

    test('if request has expected format for zero characters it returns an empty list', () async {
      when(() => characterGetter.get()).thenAnswer((_) async => Response('{"RelatedTopics":[]}', 200));
      final repo = CharacterRepository(characterGetter: characterGetter);
      final characters = await repo.fetchCharacters();
      expect(characters.length, 0);
    });

    test('if request has expected format for one character it returns a list of the characters', () async {
      when(() => characterGetter.get())
          .thenAnswer((_) async => Response('{"RelatedTopics":[{"Icon":{"URL":"/url"},"Text":"Title - Description"}]}', 200));
      final repo = CharacterRepository(characterGetter: characterGetter);
      final characters = await repo.fetchCharacters();
      expect(characters.length, 1);
      expect(characters[0].title, 'Title');
      expect(characters[0].description, 'Description');
      expect(characters[0].image, '/url');
    });

    test('if request has expected format for two characters it returns a list of the characters', () async {
      when(() => characterGetter.get()).thenAnswer((_) async => Response(
          '{"RelatedTopics":[{"Icon":{"URL":"/url"},"Text":"Title - Description"},{"Icon":{"URL":"/url2"},"Text":"Title2 - Description2"}]}', 200));
      final repo = CharacterRepository(characterGetter: characterGetter);
      final characters = await repo.fetchCharacters();
      expect(characters.length, 2);
      expect(characters[1].title, 'Title2');
      expect(characters[1].description, 'Description2');
      expect(characters[1].image, '/url2');
    });

    test('if request contains characters without the expected Title - Description format, that character is excluded', () async {
      when(() => characterGetter.get()).thenAnswer((_) async => Response(
          '{"RelatedTopics":[{"Icon":{"URL":"/url"},"Text":"Title - Description"},{"Icon":{"URL":"/url2"},"Text":"Title2 * Description2"}]}', 200));
      final repo = CharacterRepository(characterGetter: characterGetter);
      final characters = await repo.fetchCharacters();
      expect(characters.length, 1);
      expect(characters[0].title, 'Title');
      expect(characters[0].description, 'Description');
      expect(characters[0].image, '/url');
    });
  });
}
