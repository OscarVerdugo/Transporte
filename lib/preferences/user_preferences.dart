import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final _instance = new UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async{
    this._prefs = await SharedPreferences.getInstance();
  }


  final String _token = 'token';


  get token{
    return _prefs.getString(_token);
  }

  set token(String value){
    _prefs.setString(_token,value);
  }

  


}

