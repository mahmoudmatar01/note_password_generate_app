import 'package:flutter/material.dart';
import 'package:note_password_generate_app/Widgets/custom_TextFormField.dart';
import 'package:note_password_generate_app/Widgets/custom_buttom.dart';

import '../DataBase/bank_db.dart';
import '../Widgets/edit_bank_data_model_bottom_sheet.dart';

class BankAccount extends StatefulWidget {
  const BankAccount({Key? key}) : super(key: key);

  @override
  State<BankAccount> createState() => _BankAccountState();
}

class _BankAccountState extends State<BankAccount> {
  String cardName = "";
  String cardNumber = "";
  String securityCode = "";
  String validThrough = "";
  BankDataBase helper = BankDataBase();

  List<Map> banksDataList = [];

  Future<List<Map>> getData() async {
    await helper.getAccountData().then((value) {
      banksDataList = value;
      setState(() {});
    });
    return banksDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Bank Data",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          const Text(
            "Primary details",
            style: TextStyle(
                fontSize: 24,
                color: Colors.black87,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 15,
          ),
          Form(
            child: Column(
              children: [
                CustomTextFormFiel(
                    title: "Enter The Card Name",
                    onChange: (val) {
                      setState(() {
                        cardName = val;
                      });
                    },
                    icon: const Icon(
                      Icons.credit_card,
                    )),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormFiel(
                    title: "Card Number",
                    onChange: (val) {
                      setState(() {
                        cardNumber = val;
                      });
                    },
                    icon: const Icon(
                      Icons.credit_card,
                    )),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormFiel(
                    title: "Security Code",
                    onChange: (val) {
                      setState(() {
                        securityCode = val;
                      });
                    },
                    icon: const Icon(
                      Icons.credit_card,
                    )),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormFiel(
                    title: "Valid Through",
                    onChange: (val) {
                      setState(() {
                        validThrough = val;
                      });
                    },
                    icon: const Icon(
                      Icons.credit_card,
                    )),
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
                      cardName, cardNumber, securityCode, validThrough);
                  print("=============================");
                  print(response);
                  print("=============================");
                  setState(() {});
                },
              )),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Credit_Card details",
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
                                    "Credit Card Name : ${snapshot.data![index]['CardName']}",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.blue[700],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Credit Card Number : ${snapshot.data![index]['CardNumber']}",
                                    style: TextStyle(
                                      color: Colors.blue[700],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Credit_Card Security Code : ${snapshot.data![index]['SecurityCode']}",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.blue[700],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Credit_Card Valid Through : ${snapshot.data![index]['ValidThrough']}",
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
                                                  return EditBankDataModelBottom(
                                                    Card_Name:
                                                        snapshot.data![index]
                                                            ['CardName'],
                                                    Card_Number:
                                                        snapshot.data![index]
                                                            ['CardNumber'],
                                                    id: snapshot.data![index]
                                                        ['id'],
                                                    Security_Number:
                                                        snapshot.data![index]
                                                            ['SecurityCode'],
                                                    Valid_Through:
                                                        snapshot.data![index]
                                                            ['ValidThrough'],
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
                                                        "Are you Sure To Delete Bank Account Data"),
                                                    title: const Text(
                                                        "Remove Bank Data"),
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
                                                                .deleteAccountData(
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
