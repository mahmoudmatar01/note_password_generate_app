import 'package:flutter/material.dart';
import 'package:note_password_generate_app/Controller/generate_pass_controller.dart';
import 'package:note_password_generate_app/DataBase/accounts_db.dart';
import 'package:note_password_generate_app/Widgets/custom_TextFormField.dart';

import '../Widgets/custom_buttom.dart';
import '../Widgets/edit_Account_model_bottom.dart';
import '../Widgets/edit_bank_data_model_bottom_sheet.dart';

class AccountsInformation extends StatefulWidget {
  const AccountsInformation({Key? key}) : super(key: key);

  @override
  State<AccountsInformation> createState() => _AccountsInformationState();
}

class _AccountsInformationState extends State<AccountsInformation> {
  String? randomPassword;
  String platfromName = "";
  String fullName = "";
  String email = "";
  String password = "";
  List<Map> accountsList = [];
  AccountsDataBase helper = AccountsDataBase();

  Future<List<Map>> getData() async {
    await helper.getAccountsData().then((value) {
      accountsList = value;
      setState(() {});
    });
    return accountsList;
  }

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
              children: [
                CustomTextFormFiel(
                  onChange: (val) {
                    setState(() {
                      platfromName = val;
                    });
                  },
                  title: "Enter Platform Name ",
                  icon: const Icon(Icons.web),
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
                  title: "Enter Full Name ",
                  icon: const Icon(Icons.person),
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
                  title: "Enter Email",
                  icon: const Icon(Icons.email),
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
                  title: "Enter Password",
                  icon: const Icon(Icons.key),
                ),
                const SizedBox(
                  height: 10,
                ),
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
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 16))
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              height: 50,
              width: 150,
              child: CustomButton(
                title: "Save Data",
                onPress: () async {
                  int response = await helper.insertAccountData(
                      platfromName, fullName, email, password);
                  print("==========================");
                  print(response);
                  print("==========================");
                },
              )),
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
          FutureBuilder(
              future: getData(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                return !snapshot.hasData
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.blue,
                      ))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Platform Name : ${snapshot.data![index]['Platform_Name']}",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.blue[700],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Full Name : ${snapshot.data![index]['Full_Name']}",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.blue[700],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Your Email : ${snapshot.data![index]['Email']}",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.blue[700],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Your Password : ${snapshot.data![index]['Password']}",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.blue[700],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        25),
                                                                topRight: Radius
                                                                    .circular(
                                                                        25))),
                                                context: (context),
                                                builder: (_) {
                                                  return EditAccountDataModelBottom(
                                                    id: snapshot.data![index]
                                                        ['id'],
                                                    platform_Name:
                                                        snapshot.data![index]
                                                            ['Platform_Name'],
                                                    full_Name:
                                                        snapshot.data![index]
                                                            ['Full_Name'],
                                                    Email: snapshot.data![index]
                                                        ['Email'],
                                                    Password:
                                                        snapshot.data![index]
                                                            ['Password'],
                                                  );
                                                });
                                          },
                                          child: const Text(
                                            "Edit Data",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            showDialog(
                                                context: (context),
                                                builder: (_) {
                                                  return AlertDialog(
                                                    content: const Text(
                                                        "Are you Sure To Delete Account Data"),
                                                    title: const Text(
                                                        "Remove Account Data"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              "Cancel")),
                                                      TextButton(
                                                          onPressed: () async {
                                                            int response = await helper
                                                                .deleteAccountsData(
                                                                    snapshot.data![
                                                                            index]
                                                                        ['id']);
                                                            print(
                                                                "==============================");
                                                            print(response);
                                                            print(
                                                                "==============================");
                                                            if (response > 0) {
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {});
                                                            }
                                                          },
                                                          child: const Text(
                                                              "Sure"))
                                                    ],
                                                  );
                                                });
                                          },
                                          child: const Text(
                                            "Remove Data",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
              })
        ],
      ),
    );
  }
}
