import 'package:chat_application/controller/auth_controller.dart';
import 'package:chat_application/helper/firestore_helper.dart';
import 'package:chat_application/model/getmessage_model.dart';
import 'package:chat_application/model/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<GetMessageModel> fetchedmessages = [];
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    TextEditingController MessageController = TextEditingController();
    UserDataModel userDataModel =
        ModalRoute.of(context)!.settings.arguments as UserDataModel;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.person),
                ),
                SizedBox(
                  width: 8,
                ),
                Text("${userDataModel.name}")
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ZegoSendCallInvitationButton(
                    isVideoCall: true,
                    resourceID:
                        "zegouikit_call", //You need to use the resourceID that you created in the subsequent steps. Please continue reading this document.
                    invitees: [
                      ZegoUIKitUser(
                        id: userDataModel.email,
                        name: userDataModel.email,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FireStoreHelper.fireStoreHelper.GetMessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.docs.isNotEmpty) {
              fetchedmessages = snapshot.data!.docs
                  .map(
                    (e) => GetMessageModel(
                      Message: e['message'],
                      Sender: e['sender'],
                      Time: e['time'],
                    ),
                  )
                  .toList();
              return Column(
                children: [
                  Expanded(
                    flex: 14,
                    child: Container(
                      child: ListView(
                        controller: scrollController,
                        children: fetchedmessages
                            .map(
                              (e) => Row(
                                mainAxisAlignment: (e.Sender ==
                                        AuthController.CurrentUser!.email)
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Chip(
                                      label: Text("${e.Message}"),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 5),
                          child: TextField(
                            controller: MessageController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FloatingActionButton(
                            elevation: 0,
                            onPressed: () async {
                              await FireStoreHelper.fireStoreHelper
                                  .SendMessage(
                                      AuthController.CurrentUser!.email!,
                                      userDataModel.email,
                                      MessageController.text)
                                  .then(
                                    (value) => MessageController.clear(),
                                  );
                              scrollController.animateTo(
                                  scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.easeOut);
                            },
                            child: Icon(Icons.send),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    flex: 14,
                    child: Center(
                      child: Text("Send Hello"),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 5),
                          child: TextField(
                            controller: MessageController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FloatingActionButton(
                            elevation: 0,
                            onPressed: () async {
                              await FireStoreHelper.fireStoreHelper
                                  .SendMessage(
                                      AuthController.CurrentUser!.email!,
                                      userDataModel.email,
                                      MessageController.text)
                                  .then(
                                    (value) => MessageController.clear(),
                                  );
                              scrollController.animateTo(
                                  scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.easeOut);
                            },
                            child: Icon(Icons.send),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}
