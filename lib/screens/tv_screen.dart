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

class _TVScreenState extends State<TVScreen> with SingleTickerProviderStateMixin  {
  TVModel tvModel;
  String _baseLink;
  AnimationController controller;
  Animation<Offset> offset;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tvModel = widget.tvs;
    _baseLink = widget.baseLink;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tvModel.name),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[800],
     body:  Stack(
       children: [
         Hero(
           tag: 'image' + tvModel.name,
           child: Container(
             height: MediaQuery.of(context).size.height,
             width: double.infinity,
             decoration: BoxDecoration(
               image: DecorationImage(
                 image: NetworkImage(_baseLink + tvModel.poster),
                 fit: BoxFit.cover,
               ),
               borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10) )
             ),
           ),
         ),
         Positioned(
             top: 30,
             left: 10,
             child: IconButton(icon: Icon(Icons.arrow_back_ios,size: 20, color: Colors.white,), onPressed: () { Navigator.pop(context);  },)),

       ],
     ),
      bottomSheet: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.2,
          minChildSize: 0.2,
          maxChildSize: 1.0,
          builder: (context, ScrollController scrollController) {
            return Container(
              color: Colors.tealAccent[200],
              child: ListView.builder(
                controller: scrollController,
                itemCount: 25,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Text(
                        'Dish $index',
                        style: TextStyle(color: Colors.black54),
                      ));
                },
              ),

            );
          }),
    );
  }
}
