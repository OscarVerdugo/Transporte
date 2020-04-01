import 'package:app/models/user_model.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/AuthPages/phone_registration_page.dart';
import 'package:app/pages/AuthPages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:app/api/auth_provider.dart';

import 'package:app/widgets/button_widget.dart';
import 'package:app/widgets/input_widget.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _phCtrl;
  TextEditingController _pwdCtrl;
  UserModel user;
  Provider auth;

  @override
  void initState() {
    this._phCtrl = new TextEditingController(text: "");
    this._pwdCtrl = new TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _phCtrl.dispose();
    _pwdCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final size = MediaQuery.of(context).size;

    void onLogin() async {
      if (_formKey.currentState.validate()) {
        await auth.signInWithUsernameAndPassword(
            password: this._pwdCtrl.text,
            phoneNumber: this._phCtrl.text,
            context: context);
      }
    }

    void sendRegister(UserModel user) {
     auth.registerWithPhoneNumber(
        phoneNumber: user.username,
        name: user.name,
        password: user.password,
        captchaToken: user.captchaCode);
    }

    void onRegister() async {
       this.user = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>SignUp()));
       if(this.user != null){
         sendRegister(user);
       }
    }

    

    return Scaffold(
        backgroundColor: Color(0xFFF7F7FA),
        resizeToAvoidBottomPadding: true,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewPortConstraints) {
            return SafeArea(
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: viewPortConstraints.maxHeight),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SizedBox(height: 200.0),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: _title()),
                              SizedBox(
                                height: 30.0,
                              ),
                              _userPasswordWidget(),
                              SizedBox(
                                height: 40.0,
                              ),
                              ButtonWidget(
                                  child: Text("INICIAR",
                                      style: TextStyle(fontSize: 20.0)),
                                  onTap: onLogin,
                                  width: size.width * 0.5),
                              ButtonWidget(
                                  child: Text("TELEFONO",
                                      style: TextStyle(fontSize: 10.0)),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                PhoneRegistration()));
                                  },
                                  width: size.width * 0.5),
                              ButtonWidget(
                                  child: Text("Home",
                                      style: TextStyle(fontSize: 10.0)),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Home()));
                                  },
                                  width: size.width * 0.5),
                              SizedBox(
                                height: 100.0,
                              ),
                              _divider(),
                              _socialButtons(auth),
                              SizedBox(
                                height: 100.0,
                              ),
                              _createAccountLabel(onRegister)
                            ],
                          ),
                        ),
                      ),
                    )));
          },
        ));
  }

  Widget _title() {
    return Container(
        child: Text("Bienvenido",
            style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontFamily: "Segoe UI")));
  }

  Widget _createAccountLabel(Function onRegister) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '¿No tienes cuenta?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            child: Text(
              '¡Registrate!',
              style: TextStyle(
                  color: Color(0xFF29DF96),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
            onTap: () {
              onRegister();
            },
          )
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('O'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _userPasswordWidget() {
    return Column(
      children: <Widget>[
        InputWidget(
            label: "Teléfono",
            hintText: "",
            keyboardType: TextInputType.phone,
            ctrl: this._phCtrl,
            icon: Icons.phone),
        SizedBox(
          height: 20,
        ),
        InputWidget(
            label: "Contraseña",
            obscureText: true,
            ctrl: this._pwdCtrl,
            icon: Icons.lock_outline)
      ],
    );
  }

  Widget _socialButtons(AuthProvider auth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FloatingActionButton(
          heroTag: "f1",
          child: SvgPicture.asset("assets/icons/facebook_icon.svg",
              semanticsLabel: "FacebookLogo",
              color: Colors.white,
              width: 35.0,
              height: 35.0),
          onPressed: auth.signInWithFacebook,
          backgroundColor: Color(0xFF0071bc),
        ),
        SizedBox(width: 20.0),
        FloatingActionButton(
          heroTag: "f2",
          child: SvgPicture.asset("assets/icons/google_icon.svg",
              semanticsLabel: "GoogleLogo",
              color: Colors.white,
              width: 30.0,
              height: 30.0),
          onPressed: auth.signInWithFacebook,
          backgroundColor: Color(0xFFd34836),
        )
      ],
    );
  }
}
