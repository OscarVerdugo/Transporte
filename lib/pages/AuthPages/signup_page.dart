
import 'package:app/models/user_model.dart';
import 'package:app/pages/AuthPages/captcha_page.dart';
import 'package:flutter/material.dart';

import 'package:app/widgets/button_widget.dart';
import 'package:app/widgets/input_widget.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  
  TextEditingController _nameController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;
  TextEditingController _phoneNumberController;
  String cCaptchaResult;
  bool bPhoneConfirmation;
  FocusNode _passConfirmNode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    this.cCaptchaResult = null;
    this.bPhoneConfirmation = false;
    _passwordController = TextEditingController(text: "");
    _nameController = TextEditingController(text: "");

    _confirmPasswordController = TextEditingController(text: "");
    _phoneNumberController = TextEditingController(text: "");
    _passConfirmNode = FocusNode(canRequestFocus: true);
    _passConfirmNode.addListener(() {
      if (!_passConfirmNode.hasFocus) {
        if (this._passwordController.value !=
            this._confirmPasswordController.value) {}
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _passConfirmNode.dispose();
    _passwordController.dispose();
    _nameController.dispose();

    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void throwCaptcha() async {
      if(!_formKey.currentState.validate()) return;
      if (this.cCaptchaResult == null) {
        this.cCaptchaResult = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => CaptchaPage()));
        if (this.cCaptchaResult != null) {
          UserModel user = new UserModel(
              password: this._passwordController.text,
              name: this._nameController.text,
              username: this._phoneNumberController.text,
              captchaCode: this.cCaptchaResult);
          Navigator.pop(context, user);
        }else{
          Navigator.pop(context,null);
        }
      } else {}
    }

    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewPortConstraints) {
      return SafeArea(
          child: SingleChildScrollView(
              child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewPortConstraints.maxHeight),
                  child: Column(children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 50.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Registro",
                                    style: TextStyle(
                                        fontSize: 40.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                        fontFamily: "Segoe UI")),
                                Text("Llena el formulario para registrarte!",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        // fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                        fontFamily: "Segoe UI")),
                                SizedBox(height: 30.0),
                                InputWidget(
                                    ctrl: _nameController,
                                    label: "Nombre completo",
                                    hintText: "Nombres",
                                    icon: Icons.person_outline),
                                SizedBox(height: 20.0),
                                InputWidget(
                                    ctrl: _phoneNumberController,
                                    label: "Número celular",
                                    minLength: 10,
                                    hintText: "123-123-1234",
                                    icon: Icons.phone,
                                    keyboardType: TextInputType.phone),
                                SizedBox(height: 20.0),
                                InputWidget(
                                    ctrl: _passwordController,
                                    label: "Contraseña",
                                    minLength: 7,
                                    hintText: "",
                                    icon: Icons.lock_outline,
                                    obscureText: true,
                                    allowSpecials: false),
                                SizedBox(height: 20.0),
                                InputWidget(
                                    ctrl: _confirmPasswordController,
                                    node: _passConfirmNode,
                                    label: "Confirmar contraseña",
                                    minLength: 7,
                                    hintText: "",
                                    obscureText: true,
                                    icon: Icons.lock_outline,
                                    allowSpecials: false),
                                SizedBox(height: 20.0),
                                Align(
                                    child: ButtonWidget(
                                        child: Text("REGISTRARME"),
                                        onTap: () async {
                                          throwCaptcha();
                                        }),
                                    alignment: Alignment.centerRight),
                              ]),
                        ))
                  ]))));
    }));
  }
}