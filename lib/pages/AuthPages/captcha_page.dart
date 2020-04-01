import 'package:app/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recaptcha_v2/flutter_recaptcha_v2.dart';

class CaptchaPage extends StatefulWidget {
  CaptchaPage({Key key}) : super(key: key);

  @override
  _CaptchaPageState createState() => _CaptchaPageState();
}

class _CaptchaPageState extends State<CaptchaPage> {
  RecaptchaV2Controller recaptchaV2Controller = RecaptchaV2Controller();
  @override
  void initState() {
    recaptchaV2Controller.show();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          width: size.width,
          color: Colors.transparent,
          child: Stack(children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                SizedBox(width: 10.0),
                Text("Captcha",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600))
              ],
            ),
            Center(
              child: Container(
                width: size.width * 0.8,
                height: size.height * 0.8,
                child: RecaptchaV2(
                  apiKey: Keys.chaptchaApiKey,
                  controller: recaptchaV2Controller,
                  onVerifiedError: (err) {
                    Navigator.pop(context,null);
                  },
                  onVerifiedSuccessfully: (token) {
                    setState(() {
                      if (token != null) {
                        Navigator.pop(context,token);
                      } else {
                        Navigator.pop(context,null);
                      }
                    });
                  },
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  // @override
  // void dispose(){
  //   super.dispose();
  // }
  
}
