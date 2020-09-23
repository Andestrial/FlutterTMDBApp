import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_screen/models/discover_tv_model.dart';

class TVScreen extends StatefulWidget {
  TVModel tvs;
  String baseLink;
  TVScreen(this.tvs, this.baseLink);
  @override
  _TVScreenState createState() => _TVScreenState();
}

class _TVScreenState extends State<TVScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       body: Container(
         child: Column(
           children: [
             Container(
               height: 500,
               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: NetworkImage(widget.baseLink + widget.tvs.poster),
                   fit: BoxFit.fitWidth,

                 ),
                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10) )
               ),
             )
           ],
         ),
       ),
      ),
    );
  }
}
