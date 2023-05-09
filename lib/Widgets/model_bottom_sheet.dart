import 'package:flutter/material.dart';
import 'package:note_password_generate_app/Widgets/My_Alert.dart';

import '../DataBase/notes_db.dart';
import 'custom_TextFormField.dart';
import 'custom_buttom.dart';

class ModelBottomSheet extends StatefulWidget {
  ModelBottomSheet({Key? key}) : super(key: key);

  @override
  State<ModelBottomSheet> createState() => _ModelBottomSheetState();
}

class _ModelBottomSheetState extends State<ModelBottomSheet> {
  String noteTitle = "";

  String noteContent = "";

  NotesDataBase notesDataBase = NotesDataBase();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          "Enter Note Details :",
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
                  title: "Enter Note Title",
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
                  title: "Enter Note Content",
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
              title: "Save Note",
              onPress: () async {
                int response = await notesDataBase.insertData({
                  "TITLE": noteTitle,
                  "NOTE": noteContent,
                });
                if (response > 0) {
                  Navigator.pop(context);
                } else {
                  showDialog(
                      context: context,
                      builder: (_) => myAlert(
                          content: "Some Thing invalid Went",
                          context: context));
                }
              },
            ))
      ],
    );
  }
}
