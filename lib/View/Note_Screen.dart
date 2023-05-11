import 'package:flutter/material.dart';

import '../DataBase/notes_db.dart';
import '../Widgets/edit_model_bottom_sheet.dart';
import '../Widgets/model_bottom_sheet.dart';

class NoteScreen extends StatefulWidget {
  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  // Attributes
  List<Map> notes = [];
  NotesDataBase helper = NotesDataBase();

  Future<List<Map>> getNotes() async {
    await helper.getNoteMapList().then((value) {
      notes = value;
      setState(() {});
    });
    return notes;
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
                  return const SaveModelBottomSheet();
                });
          },
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
        body: FutureBuilder(
          future: getNotes(),
          builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
            return !snapshot.hasData
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, i) {
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 20),
                          onLongPress: () {
                            showDialog(
                                context: (context),
                                builder: (_) {
                                  return AlertDialog(
                                    content: const Text(
                                        "Are you Sure To Delete Note"),
                                    title: const Text("Remove Notes"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel")),
                                      TextButton(
                                          onPressed: () async {
                                            int response =
                                                await helper.deleteNote(
                                                    snapshot.data![i]["id"]);
                                            print(
                                                "==============================");
                                            print(response);
                                            print(
                                                "==============================");
                                            if (response > 0) {
                                              Navigator.pop(context);
                                              setState(() {});
                                            }
                                          },
                                          child: const Text("Sure"))
                                    ],
                                  );
                                });
                          },
                          leading: SizedBox(
                            height: 200,
                            width: 100,
                            child: Image.asset(
                              "images/notelogo.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          title: Text("${snapshot.data![i]['title']}"),
                          subtitle: Text("${snapshot.data![i]['description']}"),
                          trailing: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25))),
                                  context: (context),
                                  builder: (_) {
                                    return EditModelBottomSheet(
                                      title: snapshot.data![i]['title'],
                                      title2: snapshot.data![i]['description'],
                                      id: snapshot.data![i]['id'],
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.edit,
                            ),
                          ),
                        ),
                      );
                    });
          },
        ));
  }
}
