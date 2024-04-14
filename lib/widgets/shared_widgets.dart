import 'package:flutter/material.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
  TextInputType? type,
  bool isObscureText = false,
  Function? onSubmit,
  Function? onChange,
  Function? validate,
  Function? onTab,
  required String label,
  InputDecoration? decoration = const InputDecoration(),
  IconData? suffix,
  IconData? prefix,
  required onChanged,
}) =>
    TextFormField(
      keyboardType: type,
      controller: controller,
      onTap: () {},
      obscureText: isObscureText,
      decoration: InputDecoration(
        label: Text(label),
        suffix: Icon(suffix),
        prefix: Icon(prefix),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            style: BorderStyle.solid,
          ),
        ),
      ),
    );

Widget defaultElevatedButton({
  required Function() function,
  required String txt,
}) =>
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
      ),
      onPressed: function,
      child: Text(
        txt,
        style: const TextStyle(
          fontWeight: FontWeight.w100,
          fontFamily: 'Dosis',
          fontSize: 15.0,
          color: Colors.white,
        ),
      ),
    );

Widget buildPage(
  String title,
  String subtitle,
) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Expanded(
        child: Image.asset(
          'assets/images/inapp/onboarding.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
          bottom: 80.0,
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontFamily: 'Dosis',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
          bottom: 20.0,
        ),
        child: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 15.0,
            fontFamily: 'Dosis',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
