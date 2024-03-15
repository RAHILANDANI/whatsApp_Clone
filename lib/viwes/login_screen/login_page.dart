import 'package:chat_application/controller/auth_controller.dart';
import 'package:chat_application/helper/firebase_auth_helper.dart';
import 'package:chat_application/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    Duration loginTime = const Duration(milliseconds: 2250);
    return Scaffold(
      body: FlutterLogin(
        hideForgotPasswordButton: true,
        theme: LoginTheme(
            buttonTheme: LoginButtonTheme(
              backgroundColor: ButtonColor,
            ),
            accentColor: SecondaryColor,
            pageColorLight: PrimaryColor,
            primaryColor: ButtonColor,
            pageColorDark: SecondaryColor),
        logo: "assets/WhatsApp_icon.png",
        loginAfterSignUp: false,
        loginProviders: [
          LoginProvider(
            button: Buttons.google,
            label: "Google",
            callback: () async {
              await Future.delayed(loginTime);
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setBool('islogin', true).then(
                (value) async {
                  await AuthHelper.authHelper.LoginWithGoogle().then(
                        (value) => Get.offAllNamed('/'),
                      );
                },
              );
            },
          ),
          LoginProvider(
            button: Buttons.anonymous,
            label: "Phone",
            callback: () async {
              await Future.delayed(loginTime);
              Get.toNamed('/phone');
            },
          ),
        ],
        onLogin: (LoginData loginData) async {
          return await AuthHelper.authHelper.LoginWithUserEmailAndPassword(
              email: loginData.name, password: loginData.password);
        },
        onSignup: (SignupData signupData) async {
          return await AuthHelper.authHelper.SignUpWithEmailAndPassword(
              email: signupData.name!, password: signupData.password!);
        },
        onRecoverPassword: (_) {},
        onSubmitAnimationCompleted: () async {
          if (AuthController.CurrentUser != null) {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setBool('islogin', true).then(
              (value) {
                print("${preferences.getBool('islogin')}");
                Get.offAllNamed('/');
              },
            );
          }
        },
      ),
    );
  }
}
