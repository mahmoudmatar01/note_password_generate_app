import 'package:flutter/material.dart';
import '../DataBase/register_db.dart';
import '../Widgets/My_Alert.dart';
import '../Widgets/custom_TextFormField.dart';
import '../Widgets/custom_buttom.dart';
import 'Home_Screen.dart';
import 'SignUp.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";

  String password = "";

  RegisterDataBase helper = RegisterDataBase();

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
              height: 10,
            ),
            CustomTextFormFiel(
              onChange: (val) {
                setState(() {
                  password = val;
                });
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUp()));
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
                // await widget.baseAuthHelper.loginAuth(
                //     context: context, email: email!, password: password!);

                try {
                  var response = await helper.getAccountData(email, password);
                  print("+++++++++++++++++++++++++++++++++");
                  print(response);
                  print("+++++++++++++++++++++++++++++++++");
                  if (response.isNotEmpty) {
                    if (response[0]['Password'] == password) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    } else {
                      showDialog(
                          context: (context),
                          builder: (_) {
                            return myAlert(
                                context: context, content: "invalid Password");
                          });
                    }
                  } else {
                    showDialog(
                        context: (context),
                        builder: (_) {
                          return myAlert(
                              context: context,
                              content: "something invalid went");
                        });
                  }
                } catch (e) {
                  print("+++++++++++++++++++++++++");
                  print(e);
                  print("++++++++++++++++++++++++++");
                  showDialog(
                      context: (context),
                      builder: (_) {
                        return myAlert(
                            context: context,
                            content: "something invalid went");
                      });
                }
              },
              title: "Login",
            ),
          ],
        ),
      ),
    );
  }
}
