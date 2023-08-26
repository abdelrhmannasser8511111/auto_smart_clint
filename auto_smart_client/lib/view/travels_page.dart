import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:auto_smart_wood_working/controller/userController.dart';
import 'package:auto_smart_wood_working/view/AddNewItem.dart';
import 'package:auto_smart_wood_working/view/traelsDetails_page.dart';
import 'package:auto_smart_wood_working/view/updatePage.dart';
import 'package:auto_smart_wood_working/view/widgets/trips%20Card.dart';

import '../controller/glopal data repo.dart';
import '../model/Trip_Data_model.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({Key? key}) : super(key: key);

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      UserController().Log_out_with_timer(context);
    });

    bloc.getData_trip();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // floatingActionButton: FloatingActionButton(backgroundColor: Color(0xff01404f),onPressed: (){
      //   setState(() {
      //       Navigator.of(context).push(MaterialPageRoute(
      //                   builder: (_) => AddNewItem()
      //
      //       ));
      //   });
      //
      // },
      // child: Icon(Icons.add,color: Colors.white,),
      // ),
      body:  StreamBuilder<UnmodifiableListView<TripDataModel>>(
            initialData: UnmodifiableListView<TripDataModel>([]),
            stream: bloc.TRipsStream,
            builder: (context,snapShot) {
              return RefreshIndicator(
                onRefresh: ()async{

                   await bloc.getData_trip();
                  print("expiresIn${expiresIn}");

                },
                child: ListView.builder(
                  itemBuilder: (context,count) {
                    return TipsCard(snapShot:snapShot,count:count);
                  },
                  itemCount: snapShot.data!.length,
                ),
              );
            }
          )

    );
  }
}
