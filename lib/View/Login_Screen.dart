import 'package:flutter/material.dart';
import '../Controller/Auth_Controller.dart';
import '../Widgets/custom_TextFormField.dart';
import '../Widgets/custom_buttom.dart';
import 'SignUp.dart';

class LoginPage extends StatelessWidget {
  String? email;
  String? password;
  final BaseAuthController baseAuthHelper;

  LoginPage({super.key, required this.baseAuthHelper});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          children: [
            Text(
              "Login",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 50,
                  color: Colors.blue[500]),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: const DecorationImage(
                      fit: BoxFit.fill, image: AssetImage("images/logo2.jpg"))),
            ),
            const SizedBox(
              height: 15,
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
              height: 10,
            ),
            CustomTextFormFiel(
              onChange: (val) {
                password = val;
              },
              obscure: true,
              title: "Password",
              icon: const Icon(
                Icons.key,
                color: Colors.black54,
              ),
            ),
            Row(
              children: [
                const Text("If You haven't An Account "),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUp(
                              baseAuthHelper: AuthController(),
                            )));
                  },
                  child: const Text(
                    "Click here",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),
            CustomButton(
              onPress: () async {
                await baseAuthHelper.loginAuth(
                    context: context, email: email!, password: password!);
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //     builder: (context) => const HomeScreen()));
              },
              title: "Login",
            ),
          ],
        ),
      ),
    );
  }
}
