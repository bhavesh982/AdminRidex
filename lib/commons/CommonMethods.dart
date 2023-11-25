import 'package:flutter/material.dart';

class CommonMethods{
displaySnackBar(String msg,BuildContext context){
  var snackBar= SnackBar(content: Text(msg));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

}