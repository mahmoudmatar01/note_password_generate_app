import 'package:flutter/material.dart';
import 'package:note_password_generate_app/Controller/generate_pass_controller.dart';
import 'package:note_password_generate_app/Widgets/custom_TextFormField.dart';

import '../Widgets/custom_buttom.dart';

class AccountsInformation extends StatefulWidget {
  const AccountsInformation({Key? key}) : super(key: key);

  @override
  State<AccountsInformation> createState() => _AccountsInformationState();
}

class _AccountsInformationState extends State<AccountsInformation> {
  String? randomPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Accounts Data",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          const Text(
            "Personal Accounts Data",
            style: TextStyle(
                fontSize: 24,
                color: Colors.black87,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            child: Column(
              children: const [
                CustomTextFormFiel(
                  title: "Enter Platform Name ",
                  icon: Icon(Icons.web),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormFiel(
                  title: "Enter Full Name ",
                  icon: Icon(Icons.person),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormFiel(
                  title: "Enter Email",
                  icon: Icon(Icons.email),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormFiel(
                  title: "Enter Password",
                  icon: Icon(Icons.key),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              height: 50, width: 150, child: CustomButton(title: "Save Data")),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      randomPassword = getRandomString(15);
                    });
                  },
                  child: const Text(
                    "Generate Password ?",
                    style: TextStyle(color: Colors.blue),
                  )),
              SelectableText(randomPassword ?? "",
                  style: const TextStyle(color: Colors.black87, fontSize: 16))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Saved Data",
            style: TextStyle(
                fontSize: 24,
                color: Colors.black87,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            children: [
              SelectableText(
                "Platform Name : facebook",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.blue[700],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SelectableText(
                "Full Name : Mahmoud Mohamed Mater",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.blue[700],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SelectableText(
                "Email : mahmoudmatar@yahoo.com",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.blue[700],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SelectableText(
                "Password : $randomPassword",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.blue[700],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
