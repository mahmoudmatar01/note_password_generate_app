import 'package:flutter/material.dart';

import '../DataBase/notes_db.dart';
import 'custom_TextFormField.dart';
import 'custom_buttom.dart';

class EditModelBottomSheet extends StatefulWidget {
  final int id;
  final String title;
  final String title2;
  const EditModelBottomSheet(
      {Key? key, required this.id, required this.title, required this.title2})
      : super(key: key);
  @override
  State<EditModelBottomSheet> createState() =>
      _EditModelBottomSheet(id, title, title2);
}

class _EditModelBottomSheet extends State<EditModelBottomSheet> {
  String noteTitle = "";
  String noteContent = "";
  final int id;
  final String title;
  final String title2;
  NotesDataBase helper = NotesDataBase();

  _EditModelBottomSheet(this.id, this.title, this.title2);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          "Edit Note Details",
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w700, color: Colors.blue),
        ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            child: Column(
              children: [
                CustomTextFormFiel(
                  title: title,
                  icon: const SizedBox(),
                  onChange: (val) {
                    setState(() {
                      noteTitle = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormFiel(
                  onChange: (val) {
                    setState(() {
                      noteContent = val;
                    });
                  },
                  title: title2,
                  icon: const SizedBox(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
            height: 50,
            child: CustomButton(
              title: "Edit Note",
              onPress: () async {
                int response =
                    await helper.updateNote(noteTitle, noteContent, id);
                setState(() {});
                if (response > 0) {
                  Navigator.pop(context);
                }
                print("==================================");
                print(response);
                print("==================================");
              },
            ))
      ],
    );
  }
}
