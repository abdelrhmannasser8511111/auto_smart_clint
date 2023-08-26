import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:auto_smart_wood_working/view/travels_page.dart';
import 'package:auto_smart_wood_working/view/updatePage.dart';

import '../controller/glopal data repo.dart';
import '../model/Trip_Data_model.dart';

class TravelDetails extends StatefulWidget {
  TravelDetails({required this.count, required this.snapShot});

  AsyncSnapshot<UnmodifiableListView<TripDataModel>> snapShot;
  int count;

  @override
  State<TravelDetails> createState() => _TravelDetailsState();
}

class _TravelDetailsState extends State<TravelDetails> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // final appBarHeight =appBar.preferredSize.height;
    final statusBar = MediaQuery.of(context).padding.top;
    //  final intialHight=screenHeight-appBarHeight-statusBar;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff01404f),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: ListView(
              children: [
                Image.network(
                  "${widget.snapShot.data![widget.count].image}",
                  fit: BoxFit.cover,
                  height: screenHeight * 0.25,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.07, right: screenWidth * 0.07),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.snapShot.data![widget.count].name}",
                        style: TextStyle(
                            color: Color(0xff002134),
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        child: Text(
                          "\$${widget.snapShot.data![widget.count].price}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Color(0xff002134),
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.07, right: screenWidth * 0.07),
                  child: Text(
                    "${widget.snapShot.data![widget.count].summary}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xff002134),
                      fontSize: screenWidth * 0.035,
                      //fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
          // Container(
          //   width: double.infinity,
          //   height: screenHeight * 0.07,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       RaisedButton(
          //         onPressed: () {
          //           Navigator.of(context).pushReplacement(MaterialPageRoute(
          //               builder: (_) => UpdatePage(
          //                     snapShot: widget.snapShot,
          //                     count: widget.count,
          //                   )));
          //         },
          //         color: Color(0xff01404f),
          //         child: Text(
          //           'Update',
          //           style: TextStyle(
          //               color: Colors.white, fontSize: screenWidth * 0.05),
          //         ),
          //       ),
          //       RaisedButton(
          //         onPressed: () {
          //           setState(() {
          //             bloc.removeData_trip(widget.snapShot.data![widget.count].id,context);
          //
          //
          //           });
          //         },
          //         color: Colors.red,
          //         child: Text(
          //           'Remove',
          //           style: TextStyle(
          //               color: Colors.white, fontSize: screenWidth * 0.05),
          //         ),
          //       ),
          //
          //     ],
          //   ),
          // )
          Container(
            width: double.infinity,height: screenHeight*0.07,
            child: RaisedButton(onPressed: (){
              // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>TravelPage()));
            },color: Color(0xff01404f),
              child: Text('Order Now',style: TextStyle(color: Colors.white,fontSize: screenWidth*0.05),),),
          )
        ],
      ),
    );
  }
}
