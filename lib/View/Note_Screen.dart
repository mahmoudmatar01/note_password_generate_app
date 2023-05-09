import 'package:flutter/material.dart';

import '../DataBase/notes_db.dart';
import '../Widgets/model_bottom_sheet.dart';

class NoteScreen extends StatefulWidget {
  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  // Attributes
  List notes = [
    {
      "note":
          "Sleep Well Eat Well do exercise i will go to scchool Yeasterday by bus and i make",
      "image": "images/logo.avif"
    },
    {
      "note":
          "Sleep Well Eat Well do exercise i will go to scchool Yeasterday by bus and i make",
      "image": "images/logo.avif"
    }
  ];
  bool isLoading = true;
// readNotes Method
  Future readNotes() async {
    List<Map> response = await NotesDataBase().readData();
    notes.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "My Notes",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              context: (context),
              builder: (_) {
                return ModelBottomSheet();
              });
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, i) {
              return Dismissible(
                  key: Key("${i}"),
                  onResize: () {
                    notes.remove(notes[i]);
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Image.asset(
                              "images/logo.avif",
                              fit: BoxFit.fill,
                            )),
                        Expanded(
                            flex: 3,
                            child: ListTile(
                              title: Text("${notes[i]['note']}"),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.edit),
                              ),
                            ))
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
}
