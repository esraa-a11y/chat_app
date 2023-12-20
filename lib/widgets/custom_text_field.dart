
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({Key? key,  this.hintText, this.onChanged,this.obsecureText=false}) : super(key: key);
   Function(String)? onChanged;
    String? hintText;
    bool? obsecureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText!,
      validator: (data){
        if(data!.isEmpty){
          return 'field is required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: new BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: '$hintText',
        hintStyle: TextStyle( color: Colors.white),

      ),
    );
  }
}
