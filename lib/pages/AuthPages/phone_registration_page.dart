import 'package:app/api/auth_provider.dart';
import 'package:app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneRegistration extends StatelessWidget {

  @override

  const PhoneRegistration({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final TextEditingController phoneNumber = new TextEditingController(text: "");

    void onRegisterPhone(){
      auth.updatePhoneNumber(phoneNumber: phoneNumber.text);
    }

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewPortConstraints) {
          return SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: viewPortConstraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
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
                        children: <Widget>[
                          Text("Registra tu teléfono",
                              style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                  fontFamily: "Segoe UI")),
                          SizedBox(height: 50.0),
                          Text("Ingresa tu número telefonico",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                  fontFamily: "Segoe UI")),
                          SizedBox(height: 10.0),
                          Text(
                              "Enviaremos un código de confirmación al número telefonico que registres para validar tu cuenta.",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  // fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                  fontFamily: "Segoe UI")),
                                  SizedBox(height: 60.0),
                                  TextField(
                                    keyboardType: TextInputType.phone,
                                        controller: phoneNumber,
                                        style: TextStyle(
                                            fontSize: 30.0,
                                            fontFamily: "Segoe UI"),
                                        maxLength:10,
                                        decoration: InputDecoration(
                                          counterText: "",
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 50.0),
                                       Align(child: ButtonWidget(
                                    child: Text("GUARDAR"), onTap: onRegisterPhone),
                                    alignment: Alignment.center,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
