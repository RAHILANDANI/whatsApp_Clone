import 'package:chat_application/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Verifying your Number",
            style: TextStyle(fontSize: 20, color: SecondaryColor),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Center(
                child: Text(
                  "Waiting to automatically detect an SMS sent to",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(SecondaryColor),
                ),
                onPressed: () {
                  Get.back();
                },
                child: Text(" +91 XXXXXXXXXX Wrong Number?"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 150, right: 150),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 30),
                      hintText: "- - -  - - -"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Enter 6-digit code")
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(SecondaryColor),
                  ),
                  onPressed: () {},
                  child: Text("Verify"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
