import 'package:chat_application/controller/auth_controller.dart';
import 'package:chat_application/helper/firebase_auth_helper.dart';
import 'package:chat_application/helper/firestore_helper.dart';
import 'package:chat_application/utils/colors.dart';
import 'package:chat_application/viwes/homepage_screen/homepage_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    HomePageController homePageController = Get.put(HomePageController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SecondaryColor,
        title: Text(
            "${AuthController.CurrentUser!.email!.split('@')[0].capitalizeFirst}"),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthHelper.authHelper.signOutUser();
                SharedPreferences preference =
                    await SharedPreferences.getInstance();
                preference.setBool('islogin', false);
                Get.offAllNamed('/login');
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: GetBuilder<HomePageController>(builder: (controller) {
        return Column(
          children: homePageController.FetchAllUserData.map(
            (e) => Card(
              elevation: 3,
              child: ListTile(
                onTap: () {
                  FireStoreHelper.fireStoreHelper
                      .CreateChatRoomId(
                          AuthController.CurrentUser!.email!, e.email)
                      .then(
                        (value) => Get.toNamed('/chatpage', arguments: e),
                      );
                },
                title: Text("${e.name}"),
              ),
            ),
          ).toList(),
        );
      }),
    );
  }
}
