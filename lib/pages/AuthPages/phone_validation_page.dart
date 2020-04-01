import 'package:app/api/auth_provider.dart';
import 'package:app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneValidation extends StatefulWidget {
  PhoneValidation({Key key}) : super(key: key);

  @override
  _PhoneValidationState createState() => _PhoneValidationState();
}

class _PhoneValidationState extends State<PhoneValidation> {
  TextEditingController _fieldOne;
  TextEditingController _fieldTwo;
  TextEditingController _fieldThree;
  TextEditingController _fieldFour;
  TextEditingController _fieldFive;
  TextEditingController _fieldSix;

  FocusNode _focusOne;
  FocusNode _focusTwo;
  FocusNode _focusThree;
  FocusNode _focusFour;
  FocusNode _focusFive;
  FocusNode _focusSix;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _fieldOne = TextEditingController();
    _fieldTwo = TextEditingController();
    _fieldThree = TextEditingController();
    _fieldFour = TextEditingController();
    _fieldFive = TextEditingController();
    _fieldSix = TextEditingController();

    _focusOne = FocusNode();
    _focusTwo = FocusNode();
    _focusThree = FocusNode();
    _focusFour = FocusNode();
    _focusFive = FocusNode();
    _focusSix = FocusNode();


    _focusOne.addListener(() {
      if (_focusOne.hasFocus) _fieldOne.text = "";
    });
    _focusTwo.addListener(() {
      if (_focusTwo.hasFocus) _fieldTwo.text = "";
    });
    _focusThree.addListener(() {
      if (_focusThree.hasFocus) _fieldThree.text = "";
    });
    _focusFour.addListener(() {
      if (_focusFour.hasFocus) _fieldFour.text = "";
    });
    _focusFive.addListener(() {
      if (_focusFive.hasFocus) _fieldFive.text = "";
    });_focusSix.addListener(() {
      if (_focusSix.hasFocus) _fieldSix.text = "";
    });

    super.initState();
  }

  @override
  void dispose() {
    _fieldOne.dispose();
    _fieldTwo.dispose();
    _fieldThree.dispose();
    _fieldFour.dispose();
    _fieldFive.dispose();
    _fieldSix.dispose();


    _focusOne.dispose();
    _focusTwo.dispose();
    _focusThree.dispose();
    _focusFour.dispose();
    _focusFive.dispose();
    _focusSix.dispose();


    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    void onConfirm()async {
    if(_formKey.currentState.validate()){
      auth.verifyPhoneNumber(code: "${_fieldOne.text}${_fieldTwo.text}${_fieldThree.text}${_fieldFour.text}${_fieldFive.text}${_fieldSix.text}",resend: false);
    }
  }

    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewPortContraints) {
      return SafeArea(
          child: SingleChildScrollView(
              child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewPortContraints.maxHeight),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                  auth.signOut(context);
                                }),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 50.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("Confirma tu teléfono",
                                  style: TextStyle(
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                      fontFamily: "Segoe UI")),
                              SizedBox(height: 50.0),
                              Text("INTRODUCE CÓDIGO DE CONFIRMACIÓN",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                      fontFamily: "Segoe UI")),
                              SizedBox(height: 10.0),
                              Text(
                                  "Para terminar el registro introduce el código de cuatro digitos que hemos enviado al ",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      // fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                      fontFamily: "Segoe UI")),
                              SizedBox(height: 50.0),
                              Form(
                                key: _formKey,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: _fieldOne,
                                        focusNode: _focusOne,
                                        onChanged: (s) {
                                          FocusScope.of(context)
                                              .requestFocus(_focusTwo);
                                        },
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            fontFamily: "Segoe UI"),
                                        maxLength: 1,
                                        decoration: InputDecoration(
                                          counterText: "",
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(width: 6.0),
                                    Flexible(
                                      child: TextField(
                                        controller: _fieldTwo,
                                        focusNode: _focusTwo,
                                        keyboardType: TextInputType.number,
                                        onChanged: (s) {
                                          FocusScope.of(context)
                                              .requestFocus(_focusThree);
                                        },
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            fontFamily: "Segoe UI"),
                                        maxLength: 1,
                                        decoration: InputDecoration(
                                          counterText: "",
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(width: 6.0),
                                    Flexible(
                                      child: TextField(
                                        controller: _fieldThree,
                                        keyboardType: TextInputType.number,
                                        focusNode: _focusThree,
                                        onChanged: (s) {
                                          FocusScope.of(context)
                                              .requestFocus(_focusFour);
                                        },
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            fontFamily: "Segoe UI"),
                                        maxLength: 1,
                                        decoration: InputDecoration(
                                          counterText: "",
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(width: 6.0),
                                    Flexible(
                                      child: TextField(
                                        controller: _fieldFour,
                                        keyboardType: TextInputType.number,
                                        focusNode: _focusFour,
                                        onChanged: (s) {
                                          FocusScope.of(context).requestFocus(_focusFive);
                                        },
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            fontFamily: "Segoe UI"),
                                        maxLength: 1,
                                        decoration: InputDecoration(
                                          counterText: "",
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(width: 6.0),
                                    Flexible(
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: _fieldFive,
                                        focusNode: _focusFive,
                                        onChanged: (s) {
                                          FocusScope.of(context)
                                              .requestFocus(_focusSix);
                                        },
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            fontFamily: "Segoe UI"),
                                        maxLength: 1,
                                        decoration: InputDecoration(
                                          counterText: "",
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(width: 6.0),
                                    Flexible(
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: _fieldSix,
                                        focusNode: _focusSix,
                                        onChanged: (s) {
                                        },
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            fontFamily: "Segoe UI"),
                                        maxLength: 1,
                                        decoration: InputDecoration(
                                          counterText: "",
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 30.0),

                              Align(
                                child: ButtonWidget(
                                    child: Text("CONFIRMAR"), onTap: onConfirm),
                                alignment: Alignment.center,
                              )

                              // Expanded(child: Container())
                            ],
                          ),
                        )
                      ]))));
    }));
  }
}
