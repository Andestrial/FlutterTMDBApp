import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_screen/screens/main_screen_widgets/movie_view.dart';
import 'package:flutter_web_screen/screens/main_screen_widgets/tvs_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black54,
        body:  SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MovieView(),
                  TVView(),
                ],
              ),
          ),
        ),
        ),
    );
  }
}
