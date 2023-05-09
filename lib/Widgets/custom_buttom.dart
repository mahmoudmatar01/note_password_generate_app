import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, this.onPress, required this.title})
      : super(key: key);
  final void Function()? onPress;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        child: Container(
          width: double.infinity,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.blue[800], borderRadius: BorderRadius.circular(20)),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ));
  }
}
// () {
// Navigator.of(context).pushReplacement(
// MaterialPageRoute(builder: (context) => HomePage()));
// },
