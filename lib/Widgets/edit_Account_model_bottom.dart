import 'package:flutter/material.dart';
import 'package:note_password_generate_app/DataBase/accounts_db.dart';

import '../DataBase/bank_db.dart';
import 'custom_TextFormField.dart';
import 'custom_buttom.dart';

class EditAccountDataModelBottom extends StatefulWidget {
  const EditAccountDataModelBottom(
      {Key? key,
      required this.id,
      required this.platform_Name,
      required this.full_Name,
      required this.Email,
      required this.Password})
      : super(key: key);
  final String platform_Name;
  final String full_Name;
  final String Email;
  final String Password;
  final int id;

  @override
  State<EditAccountDataModelBottom> createState() =>
      _EditAccountDataModelBottomState(
        id,
        platform_Name,
        full_Name,
        Email,
        Password,
      );
}

class _EditAccountDataModelBottomState
    extends State<EditAccountDataModelBottom> {
  String platfromName = "";
  String fullName = "";
  String email = "";
  String password = "";

  final String platform_Name;
  final String full_Name;
  final String Email;
  final String Password;
  final int id;

  AccountsDataBase helper = AccountsDataBase();

  _EditAccountDataModelBottomState(
      this.id, this.platform_Name, this.full_Name, this.Email, this.Password);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          "Edit Account Details",
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
                  title: platform_Name,
                  icon: const SizedBox(),
                  onChange: (val) {
                    setState(() {
                      platfromName = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormFiel(
                  onChange: (val) {
                    setState(() {
                      fullName = val;
                    });
                  },
                  title: full_Name,
                  icon: const SizedBox(),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormFiel(
                  onChange: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  title: Email,
                  icon: const SizedBox(),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormFiel(
                  onChange: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  title: Password,
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
                int response = await helper.updateAccountsData(
                    platfromName, fullName, email, password, id);
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
