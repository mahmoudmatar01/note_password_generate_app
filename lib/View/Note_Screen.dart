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
      "TITLE": "Title",
      "NOTE":
          "Sleep Well Eat Well do exercise i will go to scchool Yeasterday by bus and i make",
    },
    {
      "TITLE": "Title",
      "NOTE":
          "Sleep Well Eat Well do exercise i will go to scchool Yeasterday by bus and i make",
    }
  ];
  bool isLoading = true;
// readNotes Method
  Future<List<Map<String, Object?>>> readNotes() async {
    List<Map<String, Object?>> response = await NotesDataBase().readData();
    // notes.addAll(response);
    isLoading = false;
    return response;
    // if (mounted) {
    //   setState(() {});
    // }
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
          child: ListView(
        children: [
          FutureBuilder(
              future: readNotes(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, Object?>>> snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return Dismissible(
                              key: Key("$i"),
                              onResize: () {
                                notes.remove(notes[i]);
                              },
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListTile(
                                  leading: Image.asset(
                                    "images/logo.avif",
                                    fit: BoxFit.fill,
                                  ),
                                  title: Text("${snapshot.data![i]['TITLE']}"),
                                  subtitle:
                                      Text("${snapshot.data![i]['NOTE']}"),
                                  trailing: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit),
                                  ),
                                ),
                              ));
                        })
                    : const Center(
                        child: Text("there is no Notes Until Now"),
                      );
              })
        ],
      )),
    );
  }
}
