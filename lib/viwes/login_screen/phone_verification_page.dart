import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class PhoneVerification extends StatefulWidget {
  const PhoneVerification({super.key});

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FlutterLogin(
        userType: LoginUserType.intlPhone,
        onLogin: (_) {},
        onRecoverPassword: (_) {},
      ),
    );
  }
}
