import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
//packages
import 'package:http/http.dart' as http;
import 'package:imei_plugin/imei_plugin.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//utils
import 'package:app/utils/keys.dart';
import "package:app/utils/utils.dart";
import 'package:app/preferences/user_preferences.dart';
import 'package:app/models/Status.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  WithoutPhone,
  UnverifiedPhone
}
// @immutable
class User {
  User({@required this.uid, this.usname});
  final String uid;
  final String usname;
}

class AuthProvider with ChangeNotifier {
  Status _status = Status.Unauthenticated;

  String _captchaToken = "";

  String _verificationPhoneCode = "";

  final UserPreferences prefs = new UserPreferences();

  final Map<String, String> headers = {'Content-Type': "application/json"};

  final Map<String, String> headersWithToken = {
    "Content-Type": "application/json",
    HttpHeaders.authorizationHeader: ""
  };

  Status get status => _status;

  String get captchaToken => _captchaToken;

  String get verificationPhoneCode => _verificationPhoneCode;

  set verificationPhoneCode(code) {
    _verificationPhoneCode = code;
  }

  AuthProvider();

  Future<void> signInWithUsernameAndPassword(
      {@required String phoneNumber,
      @required String password,
      @required BuildContext context}) async {
    try {
      var imei = await ImeiPlugin.getImei();
      var hashedImei = sha256.convert(utf8.encode(imei));
      Map<String,dynamic> parsedToken;

      Map<String, dynamic> payload = {
        'telefonoCelular': phoneNumber,
        'password': password,
        'fingerprint': hashedImei.toString()
      };

      _status = Status.Authenticating;
      notifyListeners();

      http.Response res = await http.post("${Keys.apiUrl}auth/login",
          body: json.encode(payload), headers: this.headers);
          print(res);
      if (res.statusCode == 200) {
        Map<String, dynamic> body = json.decode(res.body);
          if(body['data']['token'] != null){
            this.changeToken(body['data']['token'] ?? '');
            parsedToken = parseJwt(body['data']['token']);
            _status = Status.Authenticated;  
          }
          switch (parsedToken['estado']) {
            case 0:
              _status = Status.WithoutPhone;
              break;
            case 1:
              _status = Status.UnverifiedPhone;
              break;
            case 2: 
            _status = Status.Authenticated; 
              break;
            case -1:
              break;
          }
          notifyListeners();
        }else{
          print(res.statusCode);
          _status = Status.Unauthenticated;
          notifyListeners();
        }
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
    }
  }

  Future<void> signInWithFacebook() async {
    var facebookLogin = FacebookLogin();
    this._status = Status.Authenticating;
    notifyListeners();
    var facebookLoginResult = await facebookLogin.logIn(['email']);
    print("ESTATUS = ${facebookLoginResult.errorMessage}");
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        this._status = Status.Unauthenticated;
        break;
      case FacebookLoginStatus.cancelledByUser:
        this._status = Status.Unauthenticated;
        break;
      case FacebookLoginStatus.loggedIn:
        this._status = Status.Authenticated;
        break;
    }
    notifyListeners();
  }

  // Future<void> validateConfirmCode({@required String confirmCode}) async {
  //   Map<String, String> payload = {'confirmCode': confirmCode};
  //   http.Response res = await http.post("${Keys.apiUrl}auth/verify",
  //       body: json.encode(payload), headers: this.headers);
  //   if (res.statusCode == 200) {
  //       Map<String, dynamic> body = json.decode(res.body);
  //       print(body);
  //       if(body['status']){
  //         _status = Status.Authenticated;
  //         notifyListeners();
  //       }
  //   }
  // }

  void registerWithPhoneNumber(
      {@required String phoneNumber,
      @required String name,
      @required String password,
      @required String captchaToken}) async {
    Map<String, dynamic> payload = {
      'telefonoCelular': phoneNumber,
      'password': password,
      'g-recaptcha-response': captchaToken,
      'nombre': name
    };
    print(captchaToken);
    _status = Status.Authenticating;
    notifyListeners();
    http.Response res = await http.post("${Keys.apiUrl}auth/register",
        body: json.encode(payload), headers: this.headers);
    print(res.statusCode);
    print(json.decode(res.body));

    if (res.statusCode == 200) {
      Map<String, dynamic> body = json.decode(res.body);
      print(body);
      switch (body['data']['estado']) {
        case 1:
          _status = Status.UnverifiedPhone;
          notifyListeners();
          break;
      }
    } else {
      _status = Status.Unauthenticated;
      notifyListeners();
    }
  }

  dynamic updatePhoneNumber({@required phoneNumber}) async {
    Map<String, dynamic> payload = {'telefonoCelular': phoneNumber};
    http.Response res = await http.post("${Keys.apiUrl}auth/update",
        body: json.encode(payload), headers: this.headersWithToken);
    if (res.statusCode == 200) {
      Map<String, dynamic> body = json.decode(res.body);
      print(body);
      if(body['data']['estado'] == 1){
        _status = Status.UnverifiedPhone;
        notifyListeners();
      }
    }
  }

  dynamic verifyPhoneNumber({@required code, @required resend}) async {
    Map<String, dynamic> payload = {
      'code': code,
      'action': resend ? 'resend' : 'none'
    };
    http.Response res = await http.post("${Keys.apiUrl}auth/verify",
        body: json.encode(payload), headers: this.headersWithToken);
        print(this.headersWithToken);
        print(res.statusCode);
        print(res.body);
    if (res.statusCode == 200) {
      Map<String, dynamic> body = json.decode(res.body);
      if (body['data']['estado'] == 2) {
        _status = Status.Authenticated;
        refreshToken();
        notifyListeners();

      }else if(body['status'] == -13 ){
        this.resendConfirmCode();
        return -1;
      }
    }
  }

  void resendConfirmCode() async {
     Map<String, dynamic> payload = {
      'code': '',
      'action': 'resend'
    };
    http.Response res = await http.post("${Keys.apiUrl}auth/verify",
        body: json.encode(payload), headers: this.headersWithToken);
    if (res.statusCode == 200) {
      Map<String, dynamic> body = json.decode(res.body);
      if (body['data']['estado'] == 1) {
        print("se envio correctamente");
      }
    }
  }


  void signOut(BuildContext context) {
    this.prefs.token = '';
    _status = Status.Unauthenticated;
    print("LOG OUT!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    notifyListeners();
    // Navigator.pushReplacementNamed(context, 'authRouter');
  }

  void refreshToken() async {
    http.Response res = await http.post("${Keys.apiUrl}auth/refreshToken",
        body: json.encode({}), headers: this.headersWithToken);
        print(res.statusCode);
        if(res.statusCode == 200){
          Map<String,dynamic> body = json.decode(res.body);
          this.changeToken(body['data']['token']);
        }
  }

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  void test() {
    this._status = Status.Authenticated;
    notifyListeners();
  }


  void changeToken(token){
    prefs.token = token;
    this.headersWithToken[HttpHeaders.authorizationHeader] = "Bearer ${this.prefs.token}";
  }
}
