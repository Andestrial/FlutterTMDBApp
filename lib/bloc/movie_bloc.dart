import 'package:flutter_web_screen/models/movie_response.dart';
import 'package:flutter_web_screen/repository/movie_repository.dart';
import 'package:flutter_web_screen/repository/movie_repository_inc.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc {
  MovieRepository repository  = MovieRepositoryInc();
  BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

  getMovie()async{
    try {
      final movies = await repository.getMovie();
      _subject.sink.add(movies);
    }
    catch(e)
    {
      print('$e');
    }
  }

  BehaviorSubject<MovieResponse> get subject => _subject;

  dispose(){
    _subject.close();
  }

}
final movieBloc = MovieBloc();