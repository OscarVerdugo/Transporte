import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isRequired;
  final bool allowSpecials;
  final int maxLength;
  final int minLength;
  TextEditingController ctrl  = TextEditingController();
  RegExp validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
  final TextInputType keyboardType;
  final FocusNode node;
  final bool obscureText;
  IconData icon;

  InputWidget(
      {this.label,
      this.hintText = "",
      this.minLength = 0,
      this.maxLength = 999,
      this.isRequired = true,
      this.allowSpecials = false,
      this.obscureText = false,
      this.node,
      this.keyboardType = TextInputType.text,
      this.ctrl,
      this.icon}) {
    print(this.allowSpecials);
    if (this.allowSpecials)
      this.validCharacters = RegExp(r'^[a-zA-Z0-9_\-=@,\.]+$');
  }

  @override
  Widget build(BuildContext context) {
    print(this.icon);
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(fontSize: 20.0, fontFamily: "Segoe UI")),
        SizedBox(height: 10.0),
        TextFormField(
          controller: this.ctrl,
          focusNode: node,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: TextStyle(fontSize: 18.0, fontFamily: "Segoe UI"),
          decoration: InputDecoration(
            icon: this.icon != null? Icon(this.icon,color: Color(0xFF29DF96),) : null,
              hintText: hintText, hintStyle: TextStyle(color: Colors.grey)),
          validator: (value) {
            if (value.isEmpty && isRequired) return "Dato necesario!";
            if (value.length > maxLength)
              return "El dato debe de ser inferior a $maxLength caracteres!";
            if (value.length < minLength)
              return "El dato debe de ser superior a $minLength caracteres!";
            if (!validCharacters.hasMatch(value.replaceAll(" ", "")))
                return "El dato contiene caracteres no permitidos!";
            return null;
          },
        )
      ],
    ));
  }
}
