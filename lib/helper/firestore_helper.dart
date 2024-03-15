import 'package:chat_application/controller/auth_controller.dart';
import 'package:chat_application/model/fetch_chat_user_id.dart';
import 'package:chat_application/model/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static FireStoreHelper fireStoreHelper = FireStoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> AddUserInFireStoreDataBase(UserDataModel userDataModel) async {
    await firebaseFirestore.collection('user').doc().set(
      {
        'name': userDataModel.name,
        'email': userDataModel.email,
        'password': userDataModel.password
      },
    );
  }

  Future<List<QueryDocumentSnapshot>> FetchALlUserData() async {
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection('user')
        .where("email", isNotEqualTo: AuthController.CurrentUser!.email)
        .get();

    List<QueryDocumentSnapshot> data = querySnapshot.docs;
    return data;
  }

  AlreadyExistChatRoomId(String u1, String u2, FetchUserChatRoomId element) {
    if ((u1 == element.Sender || u1 == element.Receiver) &&
        (u2 == element.Sender || u2 == element.Receiver)) {
      if (u1 == element.Sender && u2 == element.Receiver) {
        AuthController.CurrentChatRoomId = "${u1}_$u2";
        print(AuthController.CurrentChatRoomId);
        print("++++++++++++++++++++++++");
      } else {
        AuthController.CurrentChatRoomId = "${u2}_$u1";
        print(AuthController.CurrentChatRoomId);
        print("-------------////////////");
      }
      return true;
    }
    return false;
  }

  Future<void> CreateChatRoomId(String Sender, String Receiver) async {
    List<FetchUserChatRoomId> FetchUserData = [];
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection('chats').get();

    List<QueryDocumentSnapshot> data = querySnapshot.docs;

    if (data.isEmpty) {
      AuthController.CurrentChatRoomId = "${Sender}_$Receiver";
      await firebaseFirestore
          .collection('chats')
          .doc(AuthController.CurrentChatRoomId)
          .set(
        {
          'chat_id': "${AuthController.CurrentChatRoomId}",
        },
      );
    } else {
      FetchUserData = data.map(
        (e) {
          String sender = e['chat_id'].toString().split("_")[0];
          String receiver = e['chat_id'].toString().split("_")[1];
          return FetchUserChatRoomId(Sender: sender, Receiver: receiver);
        },
      ).toList();
      bool AlreadyExist = false;
      for (var element in FetchUserData) {
        AlreadyExist = AlreadyExistChatRoomId(Sender, Receiver, element);
        if (AlreadyExist) {
          break;
        }
      }
      if (AlreadyExist == false) {
        AuthController.CurrentChatRoomId = "${Sender}_$Receiver";
        await firebaseFirestore
            .collection('chats')
            .doc(AuthController.CurrentChatRoomId)
            .set(
          {
            'chat_id': "${AuthController.CurrentChatRoomId}",
          },
        );
      }
    }
  }

  Future<void> SendMessage(
      String Sender, String Receiver, String Message) async {
    firebaseFirestore
        .collection('chats')
        .doc(AuthController.CurrentChatRoomId)
        .collection('messages')
        .doc()
        .set(
      {
        'sender': Sender,
        'receiver': Receiver,
        'message': Message,
        'time': DateTime.now()
      },
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> GetMessages() {
    return firebaseFirestore
        .collection('chats')
        .doc(AuthController.CurrentChatRoomId)
        .collection('messages')
        .orderBy('time', descending: false)
        .snapshots();
  }
}
