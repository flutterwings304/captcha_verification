library captcha_verification;

import 'dart:math';

import 'package:flutter/material.dart';

///Class For adding captcha verification in your app
class CaptchaVerification extends StatefulWidget {
  const CaptchaVerification(
      {Key? key,
      this.containerDecoration = const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      this.textFieldDecoration = const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter Captcha Value",
          labelText: "Enter Captcha Value"),
      this.labelStyle = const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      this.refreshWidget = const Icon(Icons.refresh),
      this.captchaStyle = const TextStyle(
          decoration: TextDecoration.lineThrough,
          letterSpacing: -1,
          fontSize: 24,
          fontStyle: FontStyle.italic),
      this.labelText = "Enter Captcha Value",
      this.errorText = "Please enter the value you see on the screen",
      this.errorStyle = const TextStyle(fontSize: 18, color: Colors.red),
      required this.onVerified,
      this.verifiedWidget = const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.verified),
          SizedBox(
            width: 5,
          ),
          Text(
            "Verified",
          )
        ],
      )})
      : super(key: key);

  ///Decoration of container in which captcha will shown
  final BoxDecoration containerDecoration;

  ///Input Decoration of textfiield where captcha will be typed
  final InputDecoration textFieldDecoration;

  /// TextStyle for captcha shown to user
  final TextStyle captchaStyle;

  ///Captcha label textstyle
  final TextStyle labelStyle;

  ///Captcha Error textstyle
  final TextStyle errorStyle;

  ///Widget that need to show for refreshing the captcha
  final Widget refreshWidget;

  /// Label Text for captcha
  final String labelText;

  /// Error Text to be shown when user enter wrong captcha
  final String errorText;

  /// To check captcha is verified or not
  final Function(bool) onVerified;

  ///Widget that need to show after captcha is verified
  final Widget verifiedWidget;
  @override
  State<CaptchaVerification> createState() => _CaptchaVerificationState();
}

class _CaptchaVerificationState extends State<CaptchaVerification> {
  String randomString = "";
  bool isVerified = false;
  String typedValue = "";

  // Logic for creating Captcha
  void buildCaptcha() {
    const letters =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    const length = 6;
    final random = Random();
    randomString = String.fromCharCodes(List.generate(
        length, (index) => letters.codeUnitAt(random.nextInt(letters.length))));
    setState(() {});
    print("the random string is $randomString");
  }

  @override
  void initState() {
    super.initState();
    buildCaptcha();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: widget.labelStyle,
          ),
          const SizedBox(
            width: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: widget.containerDecoration,
                child: Text(
                  randomString,
                  style: widget.captchaStyle,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {
                  buildCaptcha();
                },
                icon: widget.refreshWidget,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      isVerified = false;
                      typedValue = value;
                    });
                  },
                  decoration: widget.textFieldDecoration,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  isVerified = typedValue == randomString;
                  setState(() {});
                  widget.onVerified(isVerified);
                },
                child: const Text("Verify"),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (isVerified)
            widget.verifiedWidget
          else
            Text(
              widget.errorText,
              style: widget.errorStyle,
            ),
        ],
      ),
    ));
  }
}
