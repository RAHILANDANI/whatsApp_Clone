import 'package:chat_application/controller/auth_controller.dart';
import 'package:chat_application/helper/firestore_helper.dart';
import 'package:chat_application/model/user_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class AuthHelper {
  AuthHelper._();

  static final AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> LoginWithUserEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      AuthController.CurrentUser = userCredential.user;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return null;
  }

  Future<String?> SignUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserDataModel userDataModel = UserDataModel(
          name: "${email.split('@')[0].capitalizeFirst}",
          email: email,
          password: password);
      await FireStoreHelper.fireStoreHelper
          .AddUserInFireStoreDataBase(userDataModel);
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: 1317668609 /*input your AppID*/,
      appSign:
          "257c966ab8c6ce4305085320e2f0b0e5a31aea4dccc743f0b56780a085244d2e" /*input your AppSign*/,
      userID: AuthController.CurrentUser!.email!,
      userName: AuthController.CurrentUser!.email!,
      plugins: [ZegoUIKitSignalingPlugin()],
    );
    return null;
  }

  Future<void> signOutUser() async {
    await firebaseAuth.signOut();
    ZegoUIKitPrebuiltCallInvitationService().uninit();
  }

  Future<User?> LoginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    AuthController.CurrentUser = userCredential.user;
    UserDataModel userDataModel = UserDataModel(
        name:
            "${AuthController.CurrentUser!.email!.split('@')[0].capitalizeFirst}",
        email: "${AuthController.CurrentUser!.email}",
        password: "");
    await FireStoreHelper.fireStoreHelper
        .AddUserInFireStoreDataBase(userDataModel);
    print("**************************");
    print(userCredential.user!.email);
    print("**************************");

    return userCredential.user;
  }
}
