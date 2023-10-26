import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listdetail/bloc/character/character_bloc.dart';
import 'package:listdetail/bloc/character/character_event.dart';
import 'package:listdetail/model/character.dart';
import 'package:listdetail/ui/character_list_view.dart';
import 'package:listdetail/ui/character_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    required this.title,
    super.key,
  });

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Character? selectedCharacter;
  bool searching = false;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final characterState = context.watch<CharacterBloc>().state;
    print('----->home_page build filter=${characterState.filter}');
    final filteredCharacters = characterState.filteredCharacters;
    const separateListDetail = true; // TODO MediaQuery.sizeOf(context).shortestSide >= 600;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(searching ? Icons.close : Icons.search),
            onPressed: () {
              context.read<CharacterBloc>().add(const FilterUpdated(filter: ''));
              setState(() {
                searching = !searching;
                if (!searching) {
                  controller.text = '';
                }
              });
              // Perform a search action.
            },
          ),
        ],
      ),
      body: characterState.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (searching)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(hintText: 'Enter search text'),
                      onChanged: (value) {
                        context.read<CharacterBloc>().add(FilterUpdated(filter: value));
                      },
                    ),
                  ),
                Expanded(
                  child: separateListDetail
                      ? CharacterListView(
                          characters: filteredCharacters,
                          onItemSelected: (character) {
                            Navigator.pushNamed(context, '/detail', arguments: character);
                          },
                        )
                      : Row(
                          children: <Widget>[
                            Expanded(
                              child: CharacterListView(
                                characters: filteredCharacters,
                                selectedCharacter: selectedCharacter,
                                onItemSelected: (character) {
                                  setState(() {
                                    selectedCharacter = character;
                                  });
                                },
                              ),
                            ),
                            if (selectedCharacter != null)
                              Expanded(
                                child: CharacterView(
                                  character: selectedCharacter!,
                                ),
                              ),
                          ],
                        ),
                ),
              ],
            ),
    );
  }
}
