import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_screen/bloc/movie_bloc.dart';
import 'package:flutter_web_screen/bloc/tv_bloc.dart';
import 'package:flutter_web_screen/models/discover_tv_model.dart';
import 'package:flutter_web_screen/models/tv_response_model.dart';
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
        body:  Column(
            children: [
              MovieView(),
              TVView(),
            ],
          ),
        ),
    );
  }
}
