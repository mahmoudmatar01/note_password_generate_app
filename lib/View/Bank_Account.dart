import 'package:flutter/material.dart';
import 'package:note_password_generate_app/Widgets/custom_TextFormField.dart';
import 'package:note_password_generate_app/Widgets/custom_buttom.dart';

class BankAccount extends StatefulWidget {
  const BankAccount({Key? key}) : super(key: key);

  @override
  State<BankAccount> createState() => _BankAccountState();
}

class _BankAccountState extends State<BankAccount> {
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
              children: const [
                CustomTextFormFiel(
                    title: "Enter The Card Name",
                    icon: Icon(
                      Icons.credit_card,
                    )),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormFiel(
                    title: "Card Number",
                    icon: Icon(
                      Icons.credit_card,
                    )),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormFiel(
                    title: "Security Code",
                    icon: Icon(
                      Icons.credit_card,
                    )),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormFiel(
                    title: "Valid Through",
                    icon: Icon(
                      Icons.credit_card,
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              height: 50, width: 150, child: CustomButton(title: "Save Data")),
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
          Column(
            children: [
              Text(
                "Credit_Card Name : Visa",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.blue[700],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Credit_Card Number : 23632847238748738",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.blue[700],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Credit_Card Security Code : 123",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.blue[700],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Credit_Card Valid Through : 12/2025",
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
