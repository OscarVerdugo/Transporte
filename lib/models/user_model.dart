class UserModel{
  int userId;
  String username;
  String password;
  String name;
  String captchaCode;

  UserModel({this.userId,this.password,this.username,this.captchaCode,this.name});

  UserModel.fromJson({Map<String,dynamic>json}){
    this.username = json['username'];
    this.userId = json['userId'];
    this.password = json['password'];
  }

  

}