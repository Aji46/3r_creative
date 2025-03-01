// login_controller.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_creative/Controller/provider/Login_provider.dart';


class LoginController {
  final BuildContext context;
  LoginController(this.context);

  void login(String email, String password) {
    Provider.of<LoginProvider>(context, listen: false).login(context,email, password);
  }
}