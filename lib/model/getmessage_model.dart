import 'package:cloud_firestore/cloud_firestore.dart';

class GetMessageModel {
  String Message;
  Timestamp Time;
  String Sender;

  GetMessageModel(
      {required this.Message, required this.Sender, required this.Time});
}
