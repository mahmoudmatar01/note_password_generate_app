import 'package:flutter/material.dart';
import 'package:note_password_generate_app/DataBase/register_db.dart';
import '../Widgets/My_Alert.dart';
import '../Widgets/custom_TextFormField.dart';
import '../Widgets/custom_buttom.dart';
import 'Home_Screen.dart';

class SignUp extends StatefulWidget {
  SignUp({
    super.key,
  });

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "";

  String password = "";

  String firstName = "";

  String lastName = "";

  RegisterDataBase helper = RegisterDataBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
              size: 35,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Text(
          "Sign Up",
          style: TextStyle(
              fontSize: 37,
              fontWeight: FontWeight.bold,
              color: Colors.blue[500]),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                image: const DecorationImage(
                    fit: BoxFit.fill, image: AssetImage("images/logo2.jpg"))),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomTextFormFiel(
                onChange: (val) {
                  setState(() {
                    firstName = val;
                  });
                },
                title: "First Name",
                icon: const Icon(Icons.person, color: Colors.black54),
              )),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                  child: CustomTextFormFiel(
                onChange: (val) {
                  setState(() {
                    lastName = val;
                  });
                },
                title: "Last Name",
                icon: const Icon(
                  Icons.person,
                  color: Colors.black54,
                ),
              )),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          CustomTextFormFiel(
            onChange: (val) {
              setState(() {
                email = val;
              });
            },
            title: "Email",
            icon: const Icon(
              Icons.person,
              color: Colors.black54,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomTextFormFiel(
            onChange: (val) {
              setState(() {
                password = val;
              });
            },
            title: "Password",
            obscure: true,
            icon: const Icon(
              Icons.key,
              color: Colors.black54,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const CustomTextFormFiel(
            title: "verify Password",
            obscure: true,
            icon: Icon(
              Icons.key,
              color: Colors.black54,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
            onPress: () async {
              int response = await helper.insertAccountData(
                  email, password, firstName, lastName);
              print("+++++++++++++++++++++++++++++++++");
              print(response);
              print("+++++++++++++++++++++++++++++++++");
              if (response > 0) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              } else {
                showDialog(
                    context: (context),
                    builder: (_) {
                      return myAlert(
                          context: context, content: "something invalid went");
                    });
              }
            },
            title: "Sign Up",
          ),
        ],
      ),
    );
  }
}
