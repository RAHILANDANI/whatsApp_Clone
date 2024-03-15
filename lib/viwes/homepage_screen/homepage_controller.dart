import 'package:chat_application/helper/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../model/user_data_model.dart';

class HomePageController extends GetxController {
  List<UserDataModel> FetchAllUserData = [];

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    List<QueryDocumentSnapshot> data =
        await FireStoreHelper.fireStoreHelper.FetchALlUserData();

    for (var element in data) {
      FetchAllUserData.add(
        UserDataModel(
          name: element['name'],
          email: element['email'],
          password: element['password'],
        ),
      );
    }
    update();
  }
}
