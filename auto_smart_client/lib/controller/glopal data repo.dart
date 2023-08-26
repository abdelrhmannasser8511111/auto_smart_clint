import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_smart_wood_working/controller/BloC.dart';

import '../view/log_screen.dart';
import '../view/travels_page.dart';

BloC bloc=new BloC();
String? idToken;
DateTime? expiresIn;
String? email;



String? name;
int? phonenumb;
int? id;


// bool this_user_is_login_before=false;

save_user_data(String name,int phonenumb,int id ) async {
  // DateTime.now().add( Duration(seconds:expires! ));

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("name", name);
  await prefs.setInt("phonenumb", phonenumb);
  await prefs.setInt("id",id );

  print("save_user_data id  ${id}");

}
get_user_data( ) async {
  // DateTime.now().add( Duration(seconds:expires! ));

  final prefs = await SharedPreferences.getInstance();
  name= await prefs.getString("name");
  phonenumb=  await prefs.getInt("phonenumb");
  id=await prefs.getInt("id" );

  print("get_user_data id  ${id}");

}



save_login(String? Token,DateTime? expires,String? emaill ) async {
 // DateTime.now().add( Duration(seconds:expires! ));

  final prefs = await SharedPreferences.getInstance();
    await prefs.setString("idToken", Token!);
    await prefs.setString("email", emaill!);
  await prefs.setString("expiresIn",expires.toString() );

  print("expiresIn${expiresIn}");

}



check_login() async {
  print("first expiresIn${expiresIn}");

  final prefs = await SharedPreferences.getInstance();
  idToken=  await prefs.getString("idToken");
  //print("sec expiresIn${expiresIn}");

  email=  (await prefs.getString("email")) ;
//  print("troi expiresIn${expiresIn}");

  expiresIn=(await prefs.getString("expiresIn" )!=null? DateTime?.parse((await prefs.getString("expiresIn" )!)):null);
  print("end expiresIn${expiresIn}");
  print("idToken${idToken}");

}



// save_user_login(bool i) async {
//   final prefs = await SharedPreferences.getInstance();
//   this_user_is_login_before=  await prefs.setBool('this_user_is_login_before', i);
//   print("this_user_is_login_before${this_user_is_login_before}");
//
// }

// get_shared_prevrence_data() async {
//   final prefs = await SharedPreferences.getInstance();
//   this_user_is_login_before = prefs.getBool('this_user_is_login_before')==null?this_user_is_login_before:prefs.getBool('this_user_is_login_before')!;
//   print("get_shared_prevrence_data${this_user_is_login_before}");
//
// }