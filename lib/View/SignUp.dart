import 'package:flutter/material.dart';
import 'package:note_password_generate_app/Controller/Auth_Controller.dart';
import '../Widgets/custom_TextFormField.dart';
import '../Widgets/custom_buttom.dart';

class SignUp extends StatelessWidget {
  String? email;
  String? password;

  SignUp({super.key});
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
            children: const [
              Expanded(
                  child: CustomTextFormFiel(
                title: "First Name",
                icon: Icon(Icons.person, color: Colors.black54),
              )),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  child: CustomTextFormFiel(
                title: "Last Name",
                icon: Icon(
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
              email = val;
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
              password = val;
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
              await AuthController().registerAuth(
                  password: password!, email: email!, context: context);
              // Navigator.of(context).pushReplacement(
              //     MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            title: "Sign Up",
          ),
        ],
      ),
    );
  }
}
