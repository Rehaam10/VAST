import 'package:flutter/material.dart';
import 'package:rahoma_customers/providers/constants2.dart';

class AuthMainButton extends StatelessWidget {
  final String mainButtonLabel;
  final Function() onPressed;
  const AuthMainButton(
      {super.key, required this.mainButtonLabel, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Material(
        color: scaffoldColor,
        borderRadius: BorderRadius.circular(25),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width * 0.5,
          onPressed: onPressed,
          child: Text(
            mainButtonLabel,
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Dosis',
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class HaveAccount extends StatelessWidget {
  final String haveAccount;
  final String actionLabel;
  final Function() onPressed;
  const HaveAccount(
      {super.key,
      required this.actionLabel,
      required this.haveAccount,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          haveAccount,
          style: TextStyle(
            color: scaffoldColor,
            fontSize: 13,
            fontStyle: FontStyle.italic,
            fontFamily: 'Dosis',
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            actionLabel,
            style: TextStyle(
              fontFamily: 'Dosis',
              color: scaffoldColor,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        )
      ],
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'Full Name',
  hintText: 'Enter your full name',
  hintStyle: const TextStyle(
    fontFamily: 'Dosis',
  ),
  labelStyle: const TextStyle(
    fontFamily: 'Dosis',
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.black, width: 1),
    borderRadius: BorderRadius.circular(21),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.black, width: 2),
    borderRadius: BorderRadius.circular(21),
  ),
);

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^[a-zA-Z0-9\_\.\-]+[a-zA-Z0-9]*[@][a-zA-Z0-9]{2,}[\.][a-zA-Z]{2,3}$')
        .hasMatch(this);
  }
}
