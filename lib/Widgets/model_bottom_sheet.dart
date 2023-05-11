import 'package:flutter/material.dart';
import '../DataBase/notes_db.dart';
import 'custom_TextFormField.dart';
import 'custom_buttom.dart';

class SaveModelBottomSheet extends StatefulWidget {
  const SaveModelBottomSheet({Key? key}) : super(key: key);
  @override
  State<SaveModelBottomSheet> createState() => _SaveModelBottomSheet();
}

class _SaveModelBottomSheet extends State<SaveModelBottomSheet> {
  String noteTitle = "";
  String noteContent = "";
  NotesDataBase helper = NotesDataBase();

  _SaveModelBottomSheet();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          "Enter Note Details",
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
                int response = await helper.insertNote(noteTitle, noteContent);
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
