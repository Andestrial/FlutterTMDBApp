import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_web_screen/bloc/tv_bloc.dart';
import 'package:flutter_web_screen/models/discover_tv_model.dart';
import 'package:flutter_web_screen/models/tv_response_model.dart';
import 'package:flutter_web_screen/screens/widgets/error_widget.dart';

import '../tv_screen.dart';

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
        }
        else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error);
        }
        else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget buildTVScreen(TVResponse data) {
    final String baseLink = 'https://image.tmdb.org/t/p/w500/';
    List<TVModel> tvs = data.result;
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
      ),
      width: double.infinity,
      height: 230,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tvs.take(50)
              .length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),

                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TVScreen(tvs[index], baseLink)
                    ));
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 160,
                          width: 100,
                          color: Colors.black,
                          child: Image.network(
                            baseLink + tvs[index].poster, fit: BoxFit.cover,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(tvs[index].name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                        Row(
                          children: [
                            RatingBar(
                              itemSize: 10,
                              initialRating: tvs[index].votes,
                              onRatingUpdate: (double value) { print(value); },
                              itemBuilder: (context, _ ){
                                return Icon(Icons.star, color: Colors.yellow,);
                              },
                            ),
                            SizedBox(width: 5,),
                            Text('${tvs[index].votes}' , style: TextStyle(color: Colors.white),),
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