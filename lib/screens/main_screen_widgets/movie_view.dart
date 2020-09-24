import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_screen/bloc/movie_bloc.dart';
import 'package:flutter_web_screen/models/discover_movie_model.dart';
import 'package:flutter_web_screen/models/movie_response_model.dart';
import 'package:flutter_web_screen/screens/widgets/error_widget.dart';
import 'package:page_indicator/page_indicator.dart';

class MovieView extends StatefulWidget {
  @override

  _MovieViewState createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieBloc.getMovie();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: movieBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          print('here');
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            print('no here');
            return buildErrorWidget(snapshot.data.error);
          }
          return buildMovieScreen(snapshot.data);
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

  Widget buildMovieScreen(MovieResponse data) {
    List<MovieModel> movie = data.result;
    if(movie.length == 0){
      return Container(child: Text("NINE FILMES"),);
    }
    else {
      return Container(
        color: Colors.grey[800],
        height: 320,
        child: PageIndicatorContainer(
          length: movie.take(5).length,
          child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movie.take(5).length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 320,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(30, 10), bottomLeft: Radius.elliptical(30, 10)),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500/' +
                                    movie[index].poster),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 30,
                      child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(movie[index].title,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,),)),
                    )
                  ],
                );
              }),

        ),
      );
    }
  }
}
