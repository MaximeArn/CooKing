import 'package:cooking/utils.dart';
import 'package:flutter/material.dart';

enum FieldsType { Email, Age, Name, Password }

class Field extends StatelessWidget {
  final bool isPassword;
  final String labelText;
  final String placeholder;
  final bool isAge;
  final TextEditingController controller;
  final FieldsType fieldsType;

  Field(
      {this.isPassword = false,
      required this.labelText,
      required this.placeholder,
      this.isAge = false,
      required this.controller,
      required this.fieldsType});

  @override
  Widget build(BuildContext context) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final ageRegex = RegExp("^[0-9]*\$");
    final nameRegex = RegExp("^[A-Za-z,.'-]+\$");
    final passwordRegex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]');

    fieldValidator(value, FieldsType fieldtype) {
      value.trim();
      if (value.isNotEmpty) {
        // Email tests
        if ((fieldtype == FieldsType.Email) && !emailRegex.hasMatch(value)) {
          return "Invalid email format";
        }
        // Age tests
        else if (fieldtype == FieldsType.Age) {
          if (value == null || !ageRegex.hasMatch(value)) {
            return "Invalid age format";
          }

          value = int.tryParse(value);
          if (!(value > 15 && value < 100)) {
            return "Age must be between 15 and 100";
          }
        }
        // Name tests
        else if (fieldtype == FieldsType.Name) {
          if (!nameRegex.hasMatch(value)) {
            return "Only alphabetic characters allowed";
          }
          if (value.length > 25) return "Name length must be under 25";
        }
        //password tests
        else if (fieldtype == FieldsType.Password &&
            !passwordRegex.hasMatch(value)) {
          print(value);
          Utils.showSnackBar(
            text:
                "password must contains at least one number and both lower and uppercase letters",
            isError: true,
          );
          return "invalid format";
        }
        // final validation

      } else {
        return null;
      }
    }

    return Container(
      padding: EdgeInsets.only(bottom: 25),
      child: TextFormField(
        enableInteractiveSelection: false,
        validator: (value) {
          return fieldValidator(value, fieldsType);
        },
        controller: controller,
        obscureText: isPassword ? true : false,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)),
            contentPadding: EdgeInsets.only(bottom: 5, left: 25),
            labelText: labelText,
            labelStyle: TextStyle(color: Theme.of(context).primaryColor),
            hintText: isPassword ? "********" : placeholder,
            hintStyle: TextStyle(fontSize: 16)),
        keyboardType: isAge ? TextInputType.number : TextInputType.text,
      ),
    );
  }
}
