import 'package:flutter/material.dart';

abstract class AuthControllers {
  AuthControllers._();

  static final nameController = TextEditingController();
  static final lastNameController = TextEditingController();
  static final bornController = TextEditingController();
  static final positionController = TextEditingController();
  static final codeController = TextEditingController();

  static clear() {
    AuthControllers.nameController.text = '';
    AuthControllers.codeController.text = '';
    AuthControllers.bornController.text = '';
    AuthControllers.lastNameController.text = '';
    AuthControllers.positionController.text = '';
  }

}
