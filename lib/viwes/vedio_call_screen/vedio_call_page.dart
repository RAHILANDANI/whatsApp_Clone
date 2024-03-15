import 'package:chat_application/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID}) : super(key: key);
  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1317668609,
      appSign:
          "257c966ab8c6ce4305085320e2f0b0e5a31aea4dccc743f0b56780a085244d2e",
      userID: AuthController.CurrentUser!.email!,
      userName: AuthController.CurrentUser!.email!,
      callID: AuthController.CurrentChatRoomId,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
