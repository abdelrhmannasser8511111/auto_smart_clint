import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';

import '../model/Trip_Data_model.dart';
import '../model/user_data_model.dart';
import '../view/log_screen.dart';
import '../view/travels_page.dart';
import 'glopal data repo.dart';

class BloC {
  List<TripDataModel> trips = [];
  List<UserDataModel> user_Data = [];

  final _TripsStream =
      new BehaviorSubject<UnmodifiableListView<TripDataModel>>();

  Stream<UnmodifiableListView<TripDataModel>> get TRipsStream =>
      _TripsStream.stream;

  Future<Null> getData_trip() async {
    Response response = await http.get(Uri.parse(
            "https://auto-smart-wood-working-default-rtdb.firebaseio.com/product_data.json"))
        as http.Response;

    Map<String, dynamic> data = json.decode(response.body);
    print("vvvvvvv ${response.body}");
    bloc.trips.clear();
    data.forEach((key, value) async {
      trips.add(TripDataModel.fromJson(value, key));
    });
    _TripsStream.add(UnmodifiableListView(trips));

    // List<dynamic> cat_trip = data["1"]  ;
//   final a= data.map((k,e)=> trips.add(TripDataModel.fromJson(value))).;
    // _TripsStream.add(UnmodifiableListView(trips));
  }

  Future<Null> set_user_data(
      String name, int phoneNumb, int IDnumb, BuildContext context) async {
    Response response = await http.post(
        Uri.parse(
            "https://auto-smart-wood-working-default-rtdb.firebaseio.com/user_data.json"),
        body: json.encode(
            UserDataModel(name: name, idNumb: IDnumb, phoneNumber: phoneNumb)));

    print("json.encode(user_Data)  ${json.encode(response.body)}");

    if (response.statusCode == 200) {
      save_user_data(name,
          phoneNumb,IDnumb);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => TravelPage()));
    }
  }

  Future<Null> updateData_trip(var id,
      {String? name, String? summary, int? price, String? imageLink,required BuildContext context}) async {
    if (trips.length >= 0) {
      int i = trips.indexWhere((element) => id == element.id);
      Response response = await http.patch(
          Uri.parse(
              "https://auto-smart-wood-working-default-rtdb.firebaseio.com/product_data/$id.json?auth=$idToken"),
          body: json.encode(TripDataModel(
              name: name,
              summary: summary,
              price: price,
              image: imageLink))) as http.Response;
      print("update ${response.body}");
      if (response.statusCode == 200) {
        Map<dynamic, dynamic> data = json.decode(response.body);

        print("data ${data}");

        trips[i] = TripDataModel(
            name: name,
            price: price,
            summary: summary,
            image: imageLink);

        Navigator.of(context).pop();
        _TripsStream.add(UnmodifiableListView(trips));
      }
    }

  }

  Future<Null> removeData_trip(var id, BuildContext context) async {
    int i = trips.indexWhere((element) => id == element.id);

    Response response = await http.delete(
      Uri.parse(
          "https://auto-smart-wood-working-default-rtdb.firebaseio.com/product_data/$id.json?auth=$idToken"),
    ) as http.Response;
    if (response.statusCode == 200) {
      print("remove ${response.body}");

      trips.removeAt(i);
      _TripsStream.add(UnmodifiableListView(trips));

      Navigator.of(context).pop();
      //حل مؤقت
     // await getData_trip();
    }
  }

  Future<Null> newTripData(
      {String? name,
      String? summary,
      int? price,
      String? imageLink,
      required BuildContext context}) async {
    Response response = await http.post(
        Uri.parse(
            "https://auto-smart-wood-working-default-rtdb.firebaseio.com/product_data.json?auth=$idToken"),
        body: json.encode(TripDataModel(
            name: name,
            summary: summary,
            price: price,
            image: imageLink))) as http.Response;
    print("update ${response.body}");
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> data = json.decode(response.body);
      print("dataupdate ${data}");
      data.forEach((key, value) async {
        print(
            "hhhhh${TripDataModel(id: key, name: data["name"], price: data["price"], summary: data["summary"], image: data["image"])}");

        trips.add(TripDataModel(
            id: key,
            name: name,
            price: price,
            summary: summary,
            image: imageLink));
      });
      Navigator.of(context).pop();
      _TripsStream.add(UnmodifiableListView(trips));
    }

    // _TripsStream.add(UnmodifiableListView(trips));

    // List<dynamic> cat_trip = data["1"]  ;
//   final a= data.map((k,e)=> trips.add(TripDataModel.fromJson(value))).;
    // _TripsStream.add(UnmodifiableListView(trips));
  }
}
