import 'package:flutter/material.dart';
import 'package:note_password_generate_app/DataBase/notes_db.dart';

import 'Accounts_information.dart';
import 'Bank_Account.dart';
import 'Note_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int initialPageIndex = 0;
  List<Widget> screens = [
    NoteScreen(),
    const AccountsInformation(),
    const BankAccount()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.note,
              ),
              label: "Notes"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_box,
              ),
              label: "Accounts Data"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.credit_card,
              ),
              label: "Bank Data"),
        ],
        backgroundColor: Colors.grey[100],
        elevation: 0,
        selectedLabelStyle: const TextStyle(fontSize: 17),
        unselectedLabelStyle:
            const TextStyle(fontSize: 17, color: Colors.black87),
        selectedItemColor: Colors.blue[800],
        selectedIconTheme: IconThemeData(color: Colors.blue[800]),
        currentIndex: initialPageIndex,
        onTap: (index) {
          setState(() {
            initialPageIndex = index;
          });
        },
      ),
      body: screens.elementAt(initialPageIndex),
    );
  }
}
