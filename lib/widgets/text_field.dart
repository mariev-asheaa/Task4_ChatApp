import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class textformfield extends StatelessWidget {

   textformfield({this.onchanged,this.hinttext, this.icon,this.suffix,this.obsecure=false});
   Function(String)?onchanged;
   String? hinttext;
  Icon ?icon;
  bool ?obsecure; // we put default value in the constructor
  Icon?suffix;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecure!,
      validator:(data){
        if(data!.isEmpty){
    return 'This field is required';
        }
      } ,
      //requirements for the enterd data to check
      onChanged: onchanged,
      decoration: InputDecoration(
        suffixIcon: suffix,
        hintText: hinttext,
          icon: icon,
          hintStyle: TextStyle(color: Color(0xff283618),fontSize: 20),
         enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xff283618)
              )
          ),
          border: OutlineInputBorder(

      borderSide: BorderSide(
      color: Color(0xff283618)
    )
    )
      ),
    );
  }
}
