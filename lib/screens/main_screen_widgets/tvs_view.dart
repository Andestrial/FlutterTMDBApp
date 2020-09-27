import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_web_screen/bloc/tv_bloc.dart';
import 'package:flutter_web_screen/models/tv_model.dart';
import 'package:flutter_web_screen/models/tv_response.dart';
import 'package:flutter_web_screen/screens/widgets/error_widget.dart';

import '../detail_screen.dart';

class TVView extends StatefulWidget {
  @override
  _TVViewState createState() => _TVViewState();
}

class _TVViewState extends State<TVView> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tvBloc.getTv();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: tvBloc.subject.stream,
      builder: (context, AsyncSnapshot<TVResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return buildErrorWidget(snapshot.data.error);
          }
          return buildTVScreen(snapshot.data);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error);
        } else {
          return Container(
            height: 240,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget buildTVScreen(TVResponse data) {
    List<TVModel> tvs = data.result;
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      width: double.infinity,
      height: 240,
      child: ListView.builder(
          itemExtent: 120,
          scrollDirection: Axis.horizontal,
          itemCount: tvs.take(50).length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          fullscreenDialog: true,
                          transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation,
                              Widget child) {
                            return Align(
                                child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ));
                          },
                          transitionDuration: Duration(milliseconds: 400),
                          pageBuilder: (BuildContext context, __, ___) =>
                              DetailScreen( tvs[index], 'tv')));
                },
                child: Container(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Hero(
                        tag: 'image' + tvs[index].name,
                        child: Container(
                          height: 160,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                 tvs[index].poster,
                              ),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(3,3),

                              )
                            ]
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          tvs[index].name,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold,),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RatingBar(
                            itemSize: 10,
                            initialRating: tvs[index].votes,
                            onRatingUpdate: (double value) {
                              print(value);
                            },
                            itemBuilder: (context, _) {
                              return Icon(
                                Icons.star,
                                color: Colors.yellow,
                              );
                            },
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${tvs[index].votes}',
                            style: TextStyle(color: Colors.white),
                          ),

                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
