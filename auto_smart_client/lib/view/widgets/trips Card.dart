import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:auto_smart_wood_working/model/Trip_Data_model.dart';

import '../traelsDetails_page.dart';
class TipsCard extends StatefulWidget {
   TipsCard({
    required this.count,required this.snapShot
});
AsyncSnapshot<UnmodifiableListView<TripDataModel>> snapShot;
int count;
  @override
  State<TipsCard> createState() => _TipsCardState();
}

class _TipsCardState extends State<TipsCard> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // final appBarHeight =appBar.preferredSize.height;
    final statusBar = MediaQuery.of(context).padding.top;
    //  final intialHight=screenHeight-appBarHeight-statusBar;
    return Container(
        height: screenHeight * 0.35,
        width: double.infinity,
        child: Card(
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.25,
                width: double.infinity,
                child: Row(
                  children: [
                    Image.network(
                      "${widget.snapShot.data![widget.count].image}",
                      fit: BoxFit.cover,
                      height: screenHeight * 0.25,
                      width: screenWidth * 0.58,
                    ),
                    Container(
                        height: screenHeight * 0.25,
                        width: screenWidth * 0.4,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "${widget.snapShot.data![widget.count].name}",
                                style: TextStyle(
                                    color: Color(0xff002134),
                                    fontSize: screenWidth * 0.05,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "${widget.snapShot.data![widget.count].image}",
                                maxLines: 3,
                                style: TextStyle(
                                  color: Color(0xff002134),
                                  fontSize: screenWidth * 0.02,
                                ),
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.only(top: screenHeight*0.03),
                              alignment: Alignment.center,
                              child: Text(
                                "\$${widget.snapShot.data![widget.count].price}",textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xff002134),
                                    fontSize: screenWidth * 0.06,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                          ],
                        )),

                  ],
                ),
              ),
              Container(
                width: double.infinity,height: screenHeight*0.084,
                child: RaisedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>TravelDetails(count: widget.count,snapShot: widget.snapShot,)));
                },color: Color(0xff01404f),
                  child: Text('Order it now!',style: TextStyle(color: Colors.white,fontSize: screenWidth*0.05),),),
              )

              // Container(height:  screenHeight * 0.08,
              //   child: Row(
              //
              //   children: [
              //     Container(
              //
              //     width: screenWidth*0.28
              //       ,   child:Row(children: [
              //         Icon(Icons.attach_money),Text("50",style: TextStyle( fontSize: screenWidth*0.05),)
              //     ],)
              //       ,)
              //   ],
              // ),
              //
              // )
            ],
          ),
        ));
  }
}
