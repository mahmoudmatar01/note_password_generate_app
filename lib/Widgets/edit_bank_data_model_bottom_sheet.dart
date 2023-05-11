import 'package:flutter/material.dart';

import '../DataBase/bank_db.dart';
import 'custom_TextFormField.dart';
import 'custom_buttom.dart';

class EditBankDataModelBottom extends StatefulWidget {
  const EditBankDataModelBottom(
      {Key? key,
      required this.Card_Name,
      required this.Card_Number,
      required this.Security_Number,
      required this.Valid_Through,
      required this.id})
      : super(key: key);
  final String Card_Name;
  final String Card_Number;
  final String Security_Number;
  final String Valid_Through;
  final int id;

  @override
  State<EditBankDataModelBottom> createState() => _EditBankDataModelBottomState(
      Card_Name, Card_Number, Security_Number, Valid_Through, id);
}

class _EditBankDataModelBottomState extends State<EditBankDataModelBottom> {
  String cardName = "";
  String cardNumber = "";
  String securityNumber = "";
  String validThrough = "";

  final String Card_Name;
  final String Card_Number;
  final String Security_Number;
  final String Valid_Through;
  final int id;

  BankDataBase helper = BankDataBase();

  _EditBankDataModelBottomState(this.Card_Name, this.Card_Number,
      this.Security_Number, this.Valid_Through, this.id);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          "Edit BankAccount Details",
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
                  title: Card_Name,
                  icon: const SizedBox(),
                  onChange: (val) {
                    setState(() {
                      cardName = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormFiel(
                  onChange: (val) {
                    setState(() {
                      cardNumber = val;
                    });
                  },
                  title: Card_Number,
                  icon: const SizedBox(),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormFiel(
                  onChange: (val) {
                    setState(() {
                      securityNumber = val;
                    });
                  },
                  title: Security_Number,
                  icon: const SizedBox(),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormFiel(
                  onChange: (val) {
                    setState(() {
                      validThrough = val;
                    });
                  },
                  title: Valid_Through,
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
              title: "Edit Data",
              onPress: () async {
                int response = await helper.updateAccountData(
                    cardName, cardNumber, securityNumber, validThrough, id);
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
