import 'package:flutter/material.dart';
import 'package:listdetail/model/character.dart';
import 'package:listdetail/ui/character_list_view.dart';
import 'package:listdetail/ui/character_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.characters});

  final Future<List<Character>> characters;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Character? selectedCharacter;
  String searchString = '';
  bool searching = false;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool separateListDetail = false; // TODO MediaQuery.sizeOf(context).shortestSide >= 600;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
        actions: [
          IconButton(
            icon: Icon(searching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                searching = !searching;
                if (!searching) {
                  searchString = '';
                }
              });
              // Perform a search action.
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: widget.characters,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Character> allCharacters = snapshot.data!;
            List<Character> filteredCharacters =
                allCharacters.where((c) => c.title.contains(searchString) || c.description.contains(searchString)).toList();
            return Column(mainAxisSize: MainAxisSize.min, children: [
              if (searching)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(hintText: 'Enter search text'),
                    onChanged: (value) {
                      setState(() {
                        searchString = value;
                        if (searchString.isEmpty) {
                          searching = false;
                        }
                      });
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
                                }),
                          ),
                          if (selectedCharacter != null)
                            Expanded(
                              child: CharacterView(
                                character: selectedCharacter!,
                              ),
                            )
                        ],
                      ),
              ),
            ]);
          } else if (snapshot.hasError) {
            return Text(snapshot.error!.toString());
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
