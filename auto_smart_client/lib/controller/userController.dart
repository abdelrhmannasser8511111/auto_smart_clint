import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../view/log_screen.dart';
import '../view/loginData.dart';
import '../view/travels_page.dart';
import 'glopal data repo.dart';

class UserController {
  Future<Null> sign_up(String email, String password,BuildContext context) async{

    http.Response response = await http.post(
        Uri.parse(
            "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCwwV-vpKmKgOqL-QfmCjVyXzKgpp0fmfQ"),
        body: {
         // "idToken" :idToken,
          "email":email,
          "password":password,
          "returnSecureToken":"true"
        });
print("response signUP ${response.body}");
    if(response.statusCode==200){

      Map<String,dynamic> data=json.decode(response.body);
      idToken=data["idToken"];
      expiresIn = DateTime.now().add( Duration(seconds:int.parse(data["expiresIn"]) )) ;
      email=data["email"];
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => LoginData()));
      save_login(idToken,expiresIn,email);
    }
  }

  Future<Null>  sign_In(String email, String password,BuildContext context) async{

    http.Response response =await http.post(
        Uri.parse(
            "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCwwV-vpKmKgOqL-QfmCjVyXzKgpp0fmfQ"),
        body: {
          "email":email,
          "password":password,
          "returnSecureToken":"true"
        }) as http.Response;
    print("${response.body}");
    if(response.statusCode==200){

      Map<String,dynamic> data=json.decode(response.body);
      idToken=data["idToken"];
      expiresIn = DateTime.now().add( Duration(seconds:int.parse(data["expiresIn"]) )) ;
      email=data["email"];
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => TravelPage()));
      save_login(idToken,expiresIn!,email);
    }


  }
   Timer?  timer;
  Log_out_with_timer(BuildContext context){
    if(expiresIn !=null){
     final timer= Timer.periodic(Duration(seconds: 20),(_){
        if(DateTime.now().isAfter(expiresIn!) ){
          log_out(context);


        }
      });

    }


  }

  log_out(BuildContext context) async {
    print("A&A ${expiresIn}");
    idToken=null;
    expiresIn=null;
    email=null;
timer !=null? timer!.cancel():null;
    final prefs = await SharedPreferences.getInstance();
      await prefs.remove("idToken");
     (await prefs.remove("email")) ;
    await prefs.remove("expiresIn" );
    print("secccc expiresIn${expiresIn}${email}${expiresIn}");
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LogScreen()));
  }

}

